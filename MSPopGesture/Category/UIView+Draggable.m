//
//  UIView+Draggable.m
//  MSStudyDemos
//
//  Created by mr.scorpion on 16/9/1.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "UIView+Draggable.h"
#import <objc/runtime.h>

@implementation UIView (Draggable)
- (void)makeDraggable
{
    NSAssert(self.superview, @"Super view is required when make view draggable");
    [self makeDraggableInView:self.superview damping:0.4];
}
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping
{
    if (!view)
    {
        return;
    }
    [self removeDraggable];
    
    self.playground = view;
    self.damping = damping;
    
    [self creatAnimator];
    [self addPanGesture];
}

- (void)removeDraggable
{
    [self removeGestureRecognizer:self.panGesture];
    self.panGesture = nil;
    self.playground = nil;
    self.animator = nil;
    self.snapBehavior = nil;
    self.attachmentBehavior = nil;
    self.centerPoint = CGPointZero;
}

- (void)updateSnapPoint
{
    self.centerPoint = [self convertPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) toView:self.playground];
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.centerPoint];
    self.snapBehavior.damping = self.damping;
}

- (void)creatAnimator
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.playground];
    [self updateSnapPoint];
}

- (void)addPanGesture
{
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:self.panGesture];
}

#pragma mark - Gesture
- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint panLocation = [pan locationInView:self.playground];
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        UIOffset offset = UIOffsetMake(panLocation.x - self.centerPoint.x, panLocation.y - self.centerPoint.y);
        [self.animator removeAllBehaviors];
        self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self offsetFromCenter:offset attachedToAnchor:panLocation];
        [self.animator addBehavior:self.attachmentBehavior];
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        [self.attachmentBehavior setAnchorPoint:panLocation];
    }
    else if (pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled ||
             pan.state == UIGestureRecognizerStateFailed)
    {
        [self.animator removeAllBehaviors];
        [self.animator addBehavior:self.snapBehavior];
    }
}

#pragma mark - Associated Object
- (void)setPlayground:(id)object
{
    objc_setAssociatedObject(self, @selector(playground), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)playground
{
    return objc_getAssociatedObject(self, @selector(playground));
}

- (void)setAnimator:(id)object
{
    objc_setAssociatedObject(self, @selector(animator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDynamicAnimator *)animator
{
    return objc_getAssociatedObject(self, @selector(animator));
}

- (void)setSnapBehavior:(id)object
{
    objc_setAssociatedObject(self, @selector(snapBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UISnapBehavior *)snapBehavior
{
    return objc_getAssociatedObject(self, @selector(snapBehavior));
}

- (void)setAttachmentBehavior:(id)object
{
    objc_setAssociatedObject(self, @selector(attachmentBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIAttachmentBehavior *)attachmentBehavior
{
    return objc_getAssociatedObject(self, @selector(attachmentBehavior));
}

- (void)setPanGesture:(id)object
{
    objc_setAssociatedObject(self, @selector(panGesture), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIPanGestureRecognizer *)panGesture
{
    return objc_getAssociatedObject(self, @selector(panGesture));
}

- (void)setCenterPoint:(CGPoint)point
{
    objc_setAssociatedObject(self, @selector(centerPoint), [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)centerPoint
{
    return [objc_getAssociatedObject(self, @selector(centerPoint)) CGPointValue];
}

- (void)setDamping:(CGFloat)damping
{
    objc_setAssociatedObject(self, @selector(damping), @(damping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)damping
{
    return [objc_getAssociatedObject(self, @selector(damping)) floatValue];
}
@end
