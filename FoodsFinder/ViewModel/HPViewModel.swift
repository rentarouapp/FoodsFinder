//
//  HPViewModel.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import Foundation
import Combine
import Reachability

final class HPViewModel: NSObject, ObservableObject {
    @Published var shopInfoResponse: ShopInfoResponse = .init(result: nil)
    @Published var isFetching: Bool = false
    
    // EmptyViewの表示内容
    @Published var type: EmptyViewType = .initial
    // Alert
    //@Published var alertViewModel = AlertViewModel()
    
    private let apiService = APIService()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let onShopSearchSubject = PassthroughSubject<ShopInfoRequest, Never>()
    private var cancellables: [AnyCancellable] = []
    
    private func requestSend(request: ShopInfoRequest) {
        apiService.request(with: request)
            .catch { [weak self] error -> Empty<ShopInfoResponse, Never> in
                if let `self` = self {
                    self.handleAPIError(error: error)
                }
                return .init()
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error: \(error)")
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.isFetching = false
                self.shopInfoResponse = value
                if self.shopInfoResponse.result?.shops?.count ?? 0 == 0 {
                    self.type = .noResult
                }
            })
            .store(in: &cancellables)
        
        self.errorSubject
            .sink(receiveValue: { error in
                self.isFetching = false
                self.handleAPIError(error: error)
            })
            .store(in: &cancellables)
    }
    
    private func bind() {
        self.cancellables += [
            // 通信結果
            self.onShopSearchSubject
                .flatMap { [apiService] (request) in
                    apiService.request(with: request)
                        .catch { [weak self] error -> Empty<ShopInfoResponse, Never> in
                            if let `self` = self {
                                self.errorSubject.send(error)
                            }
                            return .init()
                        }
                }
                .sink(receiveValue: { [weak self] (response) in
                    guard let self = self else { return }
                    self.isFetching = false
                    self.shopInfoResponse = response
                    if self.shopInfoResponse.result?.shops?.count ?? 0 == 0 {
                        self.type = .noResult
                    }
                }),
            // エラー
            self.errorSubject
                .sink(receiveValue: { (error) in
                    self.isFetching = false
                    self.handleAPIError(error: error)
                })
        ]
    }
    
    // キーボードの検索ボタンが押されたときにView側から呼び出す
    func resumeSearch(keyword: String) {
        self.cancellables.forEach { $0.cancel() }
        self.isFetching = true
        self.bind()
        self.shopInfoResponse = .init(result: nil)
        
        let request: ShopInfoRequest = ShopInfoRequest(keyword: keyword)
        // 1: もう一つPublisherを挟んで入力値を流すケース
        self.onShopSearchSubject.send(request)
        // 2: URLSession.DataTaskPublisherに直接値を入れるケース
        //self.requestSend(request: request)
    }
    
    // 通信をキャンセルする
    func cancel() {
        self.isFetching = false
        self.cancellables.forEach { $0.cancel() }
        self.shopInfoResponse = .init(result: nil)
    }
    
    // API通信のエラーをさばく
    private func handleAPIError(error: APIServiceError) {
        do {
            let reachability = try Reachability()
            if reachability.connection == .unavailable {
                // インターネットに接続していない場合には未接続アラートを出す
//                self.alertViewModel.alertEntity.show(alertButtonType: .doubleButton,
//                                                     title: Constants.notNetWorking,
//                                                     message: Constants.notNetWorkingMessage,
//                                                     positiveTitle: Constants.commonCloseButton,
//                                                     negativeTitle: Constants.commonSetting,
//                                                     buttonAction: {
//                    // 設定に飛ばす
//                    if let settingURL = URL(string: UIApplication.openSettingsURLString) {
//                        UIApplication.shared.open(settingURL)
//                    }
//                })
                return
            }
        } catch {
            print("Reachability_failed")
        }
        switch error {
        case .invalidURL:
            print("invalidURL")
        case .responseError:
            print("responseError")
        case let .parseError(error):
            print("parseError: \(error)")
        }
    }
    
}


