//
//  WrappedError.swift
//  MealsApp
//
//  Created by Juan Ziegler on 09/08/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

struct WrappedError: Error {
  let cause: String
}
