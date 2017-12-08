//
//  UVTagsCollectionViewCell.m
//  Amigurumi Digest
//
//  Created by Basiliusic on 06/10/2017.
//  Copyright © 2017 basil. All rights reserved.
//

#import "UVTagsCollectionViewCell.h"
#import "UVTagsCollectionView.h"

static CGFloat const tagMinWidthSupplement = 16.0;
static CGFloat const tagMinHeightSupplement = 8.0;

@interface UVTagsCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation UVTagsCollectionViewCell

+(NSString *)reuseIdentifier {
    return @"TagsCollectionViewCell";
}

+(NSString *) nibName {
    return @"UVTagsCollectionViewCell";
}

-(void)initialize {
    if([self.dataSource respondsToSelector: @selector(textForTag:)]) {
        self.text = [self.dataSource textForTag: self];
    }

    if([self.dataSource respondsToSelector: @selector(fontForTag:)]) {
        self.textFont = [self.dataSource fontForTag: self];
    }

    if([self.dataSource respondsToSelector: @selector(textColorForTag:)]) {
       self.textColor = [self.dataSource textColorForTag: self];
    }

    if([self.dataSource respondsToSelector: @selector(backgroundColorForTag:)]) {
        self.backgroundColor = [self.dataSource backgroundColorForTag: self];
    }
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes: layoutAttributes];

    self.contentView.layer.cornerRadius = layoutAttributes.size.height * 0.5f;
    self.contentView.layer.masksToBounds = YES;
}

+(CGSize)minSizeWithText:(NSString *)text font: (UIFont *) font {
    CGSize calculatedSize = [text sizeWithAttributes:@{NSFontAttributeName : font}];
    CGSize minValue = CGSizeMake(calculatedSize.width + tagMinWidthSupplement, calculatedSize.height + tagMinHeightSupplement);
    return minValue;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Setters and getters
-(void)setText:(NSString *)text {
    [self.label setText: text];
}

-(NSString *) text {
    return self.label.text;
}

-(void)setTextFont:(UIFont *)textFont {
    self.label.font = textFont;
}

-(UIFont *)textFont {
    return self.label.font;
}

-(void)setTextColor:(UIColor *)textColor {
    self.label.textColor = textColor;
}

-(UIColor *)textColor {
    return self.label.textColor;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor {
    self.contentView.backgroundColor = backgroundColor;
}

-(UIColor *) backgroundColor {
    return self.contentView.backgroundColor;
}

#pragma mark - Touch
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesEnded: touches withEvent: event];

    UITouch *touch = touches.allObjects.firstObject;
    CGPoint touchLocation = [touch locationInView: self];

    if(CGRectContainsPoint(self.contentView.bounds, touchLocation)) {
        [self.delegate didClickOnTag: self];
    }
}

@end
