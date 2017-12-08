//
// Created by Basiliusic on 06/10/2017.
// Copyright (c) 2017 basil. All rights reserved.
//

#import "UVTagsCollectionViewCell.h"

@import Foundation;
@import UIKit;

@protocol UVTagsDataSource;
@protocol UVTagsDelegate;

IB_DESIGNABLE

@interface UVTagsCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UVTagDataSource, UVTagDelegate>
@property (nonatomic, weak) IBOutlet id<UVTagsDataSource> tagsDataSource;
@property (nonatomic, weak) IBOutlet id<UVTagsDelegate> tagsDelegate;

@property (nonatomic, strong) NSArray<NSString *> *tagNames;
@property (nonatomic, strong) UIFont *tagFont;
@property (nonatomic, strong) UIColor *tagTextColor;
@property (nonatomic, strong) UIColor *tagBackgroundColor;

@property (nonatomic, assign) IBInspectable CGFloat tagsInterItemsSpacing;
@property (nonatomic, assign) IBInspectable CGFloat tagsLineSpacing;

@property (nonatomic, assign) IBInspectable CGFloat tagsInsetsLeftEdge;
@property (nonatomic, assign) IBInspectable CGFloat tagsInsetsBottomEdge;
@property (nonatomic, assign) IBInspectable CGFloat tagsInsetsRightEdge;
@property (nonatomic, assign) IBInspectable CGFloat tagsInsetsTopEdge;

- (instancetype)initWithDataSource:(id <UVTagsDataSource>)dataSource delegate:(id <UVTagsDelegate>)delegate tagsInterItemSpacing:(NSUInteger)tagsInterItemSpacing tagsLineSpacing:(NSUInteger)tagsLineSpacing tagsInsets:(UIEdgeInsets)tagInsets;
- (instancetype)initWithTagNames:(NSArray<NSString *> *)tagNames tagFont:(UIFont *)tagFont tagTextColor:(UIColor *)tagTextColor tagBackgroundColor:(UIColor *)tagBackgroundColor tagsInterItemSpacing:(NSUInteger)tagsInterItemSpacing tagsLineSpacing:(NSUInteger)tagsLineSpacing tagsInsets:(UIEdgeInsets)tagInsets;
@end

@protocol UVTagsDataSource <NSObject>
@optional
-(NSArray<NSString *> *)tagNamesForTagsCollectionView: (UVTagsCollectionView *) tagsCollectionView;

-(UIFont *)fontForTagWithIndexPath: (NSIndexPath *) indexPath inTagsCollectionView: (UVTagsCollectionView *) tagsCollectionView;
-(UIColor *)textColorForTagWithIndexPath: (NSIndexPath *) indexPath inTagsCollectionView: (UVTagsCollectionView *) tagsCollectionView;
-(UIColor *)backgroundColorForTagWithIndexPath: (NSIndexPath *) indexPath inTagsCollectionView: (UVTagsCollectionView *) tagsCollectionView;
-(CGSize) sizeForTagWithIndexPath: (NSIndexPath *) indexPath minimalSize: (CGSize) minimalSize inTagsCollectionView: (UVTagsCollectionView *) tagsCollectionView;
@end

@protocol UVTagsDelegate <NSObject>
@optional
-(void) tagsCollectionView: (UVTagsCollectionView *) tagsCollectionView didClickOnTagWithIndexPath: (NSIndexPath *) indexPath;
-(void) tagsCollectionView: (UVTagsCollectionView *) tagsCollectionView didChangeContentSizeFrom: (CGSize) fromContentSize to: (CGSize) toContentSize;
@end