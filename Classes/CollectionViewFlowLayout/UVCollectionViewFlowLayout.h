//
// Created by Basiliusic on 07/10/2017.
// Copyright (c) 2017 basil. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface UVCollectionViewFlowLayout : UICollectionViewFlowLayout
-(instancetype)initWithInterItemSpacing:(CGFloat)interItemSpacing lineSpacing:(CGFloat)lineSpacing edgeInsets: (UIEdgeInsets) edgeInsets;
@end