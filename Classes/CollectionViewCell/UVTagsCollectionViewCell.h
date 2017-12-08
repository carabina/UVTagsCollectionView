//
//  UVTagsCollectionViewCell.h
//  Amigurumi Digest
//
//  Created by Basiliusic on 06/10/2017.
//  Copyright © 2017 basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UVTagsCollectionView;
@protocol UVTagDataSource;
@protocol UVTagDelegate;

@interface UVTagsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, weak) UVTagsCollectionView<UVTagDataSource> *dataSource;
@property (nonatomic, weak) UVTagsCollectionView<UVTagDelegate> *delegate;

+(NSString *)reuseIdentifier;
+(NSString *) nibName;
+(CGSize)minSizeWithText:(NSString *)text font: (UIFont *) font;
-(void)initialize;
@end

@protocol UVTagDataSource <NSObject>
@optional
-(NSString *) textForTag: (UVTagsCollectionViewCell *) tag;
-(UIFont *) fontForTag: (UVTagsCollectionViewCell *) tag;
-(UIColor *) textColorForTag: (UVTagsCollectionViewCell *) tag;
-(UIColor *) backgroundColorForTag: (UVTagsCollectionViewCell *) tag;
@end

@protocol UVTagDelegate <NSObject>
@required
-(void) didClickOnTag: (UVTagsCollectionViewCell *) tag;
@end
