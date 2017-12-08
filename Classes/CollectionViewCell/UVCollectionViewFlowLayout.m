//
// Created by Basiliusic on 07/10/2017.
// Copyright (c) 2017 basil. All rights reserved.
//

#import "UVCollectionViewFlowLayout.h"

//static CGFloat const spaceBetweenCells = 6.0;
//static CGFloat const minimumLineSpacing = 2.0;

@interface UVCollectionViewFlowLayout ()
@property (nonatomic, assign) CGFloat spaceBetweenCells;
@property (nonatomic, assign) CGFloat lineSpacing;

@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *layoutAttributes;
@property (nonatomic, assign) CGSize _collectionViewContentSize;

@end

@implementation UVCollectionViewFlowLayout

-(instancetype)initWithInterItemSpacing:(CGFloat)interItemSpacing lineSpacing:(CGFloat)lineSpacing edgeInsets:(UIEdgeInsets)edgeInsets {
    self = [self init];
    if(self) {
        self.spaceBetweenCells = interItemSpacing;
        self.lineSpacing = lineSpacing;
        self.sectionInset = edgeInsets;
    }

    return self;
}

-(CGSize)collectionViewContentSize {
    return self._collectionViewContentSize;
}

-(CGSize)itemSize {
    return CGSizeMake(10.0, 10.0);
}

-(CGSize)estimatedItemSize {
    return CGSizeMake(10.0, 10.0);
}

-(void)prepareLayout {
    [super prepareLayout];
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [NSMutableArray new];

    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection: 0];

    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;

    CGFloat nextItemXStartPosition = 0.0;
    CGFloat nextItemYStartPosition = 0.0;

    CGFloat sectionInsetRight = self.sectionInset.right;
    CGFloat sectionInsetTop = self.sectionInset.top;
    CGFloat contentWidth = self.collectionView.frame.size.width - self.sectionInset.right - self.sectionInset.left;
    
    CGFloat currentLineItemMaximumHeight = 0.0f;

    for(NSInteger currentItem = 0; currentItem < numberOfItems; currentItem++) {
        NSIndexPath *currentItemIndexPath = [NSIndexPath indexPathForItem: currentItem inSection: 0];
        UICollectionViewLayoutAttributes * currentItemLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: currentItemIndexPath];
        CGSize itemSize = [delegate collectionView: self.collectionView layout: self sizeForItemAtIndexPath: currentItemIndexPath];

        currentItemLayoutAttributes.frame = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);

        if(itemSize.height > currentLineItemMaximumHeight) {
            currentLineItemMaximumHeight = itemSize.height;
        }

        if(itemSize.width + nextItemXStartPosition <= contentWidth) {
            currentItemLayoutAttributes.center = CGPointMake(nextItemXStartPosition + itemSize.width / 2.0f + sectionInsetRight, nextItemYStartPosition + itemSize.height / 2.0f + sectionInsetTop);
            nextItemXStartPosition += itemSize.width + self.spaceBetweenCells;
        }
        else {
            nextItemXStartPosition = itemSize.width + self.spaceBetweenCells;
            nextItemYStartPosition += currentLineItemMaximumHeight + self.lineSpacing;
            currentLineItemMaximumHeight = itemSize.height;
            currentItemLayoutAttributes.center = CGPointMake(itemSize.width / 2.0f + sectionInsetRight, nextItemYStartPosition + itemSize.height / 2.0f + sectionInsetTop);
        }

        [layoutAttributes addObject: currentItemLayoutAttributes];
    }

    self.layoutAttributes = layoutAttributes;
    self._collectionViewContentSize = CGSizeMake(contentWidth, MAX(nextItemYStartPosition, currentLineItemMaximumHeight) + self.sectionInset.bottom);
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutAttributes[(NSUInteger)(indexPath.item)];
}


@end
