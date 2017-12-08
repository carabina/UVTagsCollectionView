//
// Created by Basiliusic on 06/10/2017.
// Copyright (c) 2017 basil. All rights reserved.
//

#import "UVTagsCollectionView.h"
#import "UVCollectionViewFlowLayout.h"

static void *CollectionViewContentSizeContext = &CollectionViewContentSizeContext;

@interface UVTagsCollectionView ()

@end

@implementation UVTagsCollectionView
-(instancetype) init {
    self = [super init];

    if(self) {

    }

    return self;
}

- (instancetype)initWithDataSource:(id <UVTagsDataSource>)dataSource delegate:(id <UVTagsDelegate>)delegate tagsInterItemSpacing:(NSUInteger)tagsInterItemSpacing tagsLineSpacing:(NSUInteger)tagsLineSpacing tagsInsets:(UIEdgeInsets)tagInsets {
    self = [self init];

    if(self) {
        self.tagsDataSource = dataSource;
        self.tagsDelegate = delegate;

        self.tagsInterItemsSpacing = tagsInterItemSpacing;
        self.tagsLineSpacing = tagsLineSpacing;
        self.tagsInsetsRightEdge = tagInsets.right;
        self.tagsInsetsTopEdge = tagInsets.top;
        self.tagsInsetsBottomEdge = tagInsets.bottom;
        self.tagsInsetsLeftEdge = tagInsets.left;

        [self _init];
    }

    return self;
}

- (instancetype)initWithTagNames:(NSArray<NSString *> *)tagNames tagFont:(UIFont *)tagFont tagTextColor:(UIColor *)tagTextColor tagBackgroundColor:(UIColor *)tagBackgroundColor tagsInterItemSpacing:(NSUInteger)tagsInterItemSpacing tagsLineSpacing:(NSUInteger)tagsLineSpacing tagsInsets:(UIEdgeInsets)tagInsets {
    self = [self init];

    if(self) {
        self.tagNames = tagNames;
        self.tagFont = tagFont;
        self.tagTextColor = tagTextColor;
        self.tagBackgroundColor = tagBackgroundColor;

        self.tagsInterItemsSpacing = tagsInterItemSpacing;
        self.tagsLineSpacing = tagsLineSpacing;
        self.tagsInsetsRightEdge = tagInsets.right;
        self.tagsInsetsTopEdge = tagInsets.top;
        self.tagsInsetsBottomEdge = tagInsets.bottom;
        self.tagsInsetsLeftEdge = tagInsets.left;

        [self _init];
    }

    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];

    if(self) {

    }

    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];

    if(self) {

    }

    return self;
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame: frame collectionViewLayout: layout];

    if(self) {

    }
    return self;
}

-(void) awakeFromNib {
    [super awakeFromNib];

    [self _init];
}

-(void) _init {
    [self registerNib:[UINib nibWithNibName: UVTagsCollectionViewCell.nibName bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: UVTagsCollectionViewCell.reuseIdentifier];
    self.dataSource = self;
    self.delegate = self;
    self.collectionViewLayout = [[UVCollectionViewFlowLayout alloc] initWithInterItemSpacing:self.tagsInterItemsSpacing lineSpacing:self.tagsLineSpacing edgeInsets:UIEdgeInsetsMake(self.tagsInsetsTopEdge, self.tagsInsetsLeftEdge, self.tagsInsetsBottomEdge, self.tagsInsetsRightEdge)];
}

#pragma mark - Reload data
-(void)reloadData {
    if(self.tagsDataSource) {
        if([self.tagsDataSource respondsToSelector: @selector(tagNamesForTagsCollectionView:)]) {
            self.tagNames = [self.tagsDataSource tagNamesForTagsCollectionView: self];
        }
    }

    [super reloadData];
}

#pragma mark - ContentSize observer
-(void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    if(context == CollectionViewContentSizeContext) {
        NSValue *oldSizeValue = change[NSKeyValueChangeOldKey];
        CGSize oldSize = oldSizeValue.CGSizeValue;

        NSValue *newSizeValue = change[NSKeyValueChangeNewKey];
        CGSize newSize = newSizeValue.CGSizeValue;

        if(!CGSizeEqualToSize(oldSize, newSize)) {
            if([self.tagsDelegate respondsToSelector: @selector(tagsCollectionView:didChangeContentSizeFrom:to:)]) {
                [self.tagsDelegate tagsCollectionView: self didChangeContentSizeFrom: oldSize to: newSize];
            }
        }
    } else {
        [super observeValueForKeyPath: keyPath ofObject: object change: change context: context];
    }
}

-(void)willMoveToWindow:(nullable UIWindow *)newWindow {
    if(!newWindow) {
        [self removeObserver: self forKeyPath: @"contentSize" context: CollectionViewContentSizeContext];
    }

    [super willMoveToWindow: newWindow];
}

-(void)didMoveToWindow {
    if(self.window) {
        [self addObserver: self forKeyPath: @"contentSize" options: NSKeyValueObservingOptionOld + NSKeyValueObservingOptionNew context: CollectionViewContentSizeContext];
    }

    [super didMoveToWindow];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagNames.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UVTagsCollectionViewCell *tagCell = [self dequeueReusableCellWithReuseIdentifier: UVTagsCollectionViewCell.reuseIdentifier forIndexPath: indexPath];

    tagCell.dataSource = self;
    tagCell.delegate = self;

    [tagCell initialize];

    return tagCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize minimalSize = [UVTagsCollectionViewCell minSizeWithText:[self textForTagWithIndexPath:indexPath] font:[self fontForTagWithIndexPath:indexPath]];
    CGSize requestSize = CGSizeZero;
    if([self.tagsDataSource respondsToSelector:@selector(sizeForTagWithIndexPath:minimalSize:inTagsCollectionView:)]) {
        requestSize = [self.tagsDataSource sizeForTagWithIndexPath: indexPath minimalSize: minimalSize inTagsCollectionView: self];
    }

    CGFloat cellWidth = MAX(minimalSize.width, requestSize.width);
    CGFloat cellHeight = MAX(minimalSize.height, requestSize.height);
    CGSize cellSize = CGSizeMake(cellWidth, cellHeight);

    return cellSize;
}



#pragma mark - UVTagDataSource
-(NSString *)textForTag:(UVTagsCollectionViewCell *)tag {
    return [self textForTagWithIndexPath: [self indexPathForItemAtPoint:tag.center]];
}

-(NSString *) textForTagWithIndexPath: (NSIndexPath *) indexPath {
    return self.tagNames[(NSUInteger) indexPath.item];
}

-(UIFont *)fontForTag:(UVTagsCollectionViewCell *)tag {

    return [self fontForTagWithIndexPath: [self indexPathForItemAtPoint: tag.center]];
}

-(UIFont *) fontForTagWithIndexPath: (NSIndexPath *) indexPath {
    UIFont *tagFont = self.tagFont;

    if([self.tagsDataSource respondsToSelector: @selector(fontForTagWithIndexPath:inTagsCollectionView:)]) {
        tagFont = [self.tagsDataSource fontForTagWithIndexPath: indexPath inTagsCollectionView: self];
    }

    return tagFont;
}

-(UIColor *)textColorForTag:(UVTagsCollectionViewCell *)tag {
    UIColor *tagTextColor = self.tagTextColor;
    NSIndexPath *indexPath = [self indexPathForItemAtPoint: tag.center];

    if([self.tagsDataSource respondsToSelector: @selector(textColorForTagWithIndexPath:inTagsCollectionView:)]) {
        tagTextColor = [self.tagsDataSource textColorForTagWithIndexPath: indexPath inTagsCollectionView: self];
    }

    return tagTextColor;
}

-(UIColor *)backgroundColorForTag:(UVTagsCollectionViewCell *)tag {
    UIColor *tagBackgroundColor = self.tagBackgroundColor;
    NSIndexPath *indexPath = [self indexPathForItemAtPoint: tag.center];

    if([self.tagsDataSource respondsToSelector: @selector(backgroundColorForTagWithIndexPath:inTagsCollectionView:)]) {
        tagBackgroundColor = [self.tagsDataSource backgroundColorForTagWithIndexPath: indexPath inTagsCollectionView: self];
    }

    return tagBackgroundColor;
}

#pragma mark - UVTagDelegate
-(void)didClickOnTag:(UVTagsCollectionViewCell *)tag {
    if([self.tagsDelegate respondsToSelector: @selector(tagsCollectionView:didClickOnTagWithIndexPath:)]) {
        NSIndexPath *indexPath = [self indexPathForItemAtPoint: tag.center];
        [self.tagsDelegate tagsCollectionView: self didClickOnTagWithIndexPath: indexPath];
    }
}


@end
