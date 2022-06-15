//
//  SearchPresenter.swift
//  MusicByApple
//
//  Created by lion on 12.06.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
  func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
  weak var viewController: SearchDisplayLogic?
  
  func presentData(response: Search.Model.Response.ResponseType) {
      switch response {
          
      case .some:
          print("response.some")
      case .presentTracks(let searchResults):
          searchResults?.results
          print("response.presentTracks")
          viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks)
      }
  
  }
  
}
