//
//  stateDelegate.swift
//  WhatAppExercise
//
//  Created by 张昊 on 14/11/17.
//  Copyright (c) 2014年 HaoYa. All rights reserved.
//

import Foundation


protocol stateDelegate{
    func isOn(zhuangtai:WXstate)
    func isOff(zhuangtai:WXstate)
    func meOff()
}