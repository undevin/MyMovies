//
//  DebouncedText.swift
//  MyMovies
//
//  Created by Devin on 5/23/21.
//

import Combine
import Foundation

class DebouncedText: ObservableObject {
    @Published var text = ""
    @Published var debouncedText = ""
    
    private var textDebounce: AnyCancellable?
    
    init() {
        textDebounce = $text
            .debounce(for: .seconds(0.9), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.debouncedText = $0
            }
    }
}//End of Class
