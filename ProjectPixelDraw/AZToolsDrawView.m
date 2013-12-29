//
//  AZToolsDrawView.m
//  ProjectPixelDraw
//
//  Created by Alex Alexandrov on 19.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZToolsDrawView.h"

@implementation AZToolsDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.colorFrame = [UIColor redColor];
        self.rectFrame = CGRectMake(20, 45, 40, 40);
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef contextToolsView = UIGraphicsGetCurrentContext();
    
    [self textInTools:@"Pixel color" andPointText:CGPointMake(15, 10)];
    
    [self checkinColorFrame:contextToolsView colorFrame:self.colorFrame andRectFrame:self.rectFrame];
    
    [self textInTools:@"Pixel size" andPointText:CGPointMake(15, 170)];
    
    
    
    
}

- (void) checkinColorFrame: (CGContextRef) context colorFrame: (UIColor *) colorFrame andRectFrame: (CGRect) rectFrame{
    
    CGContextSetStrokeColorWithColor(context, colorFrame.CGColor);
    CGContextAddRect(context, rectFrame);
    CGContextStrokePath(context);
    
}

- (void) textInTools: (NSString *) stringTools andPointText: (CGPoint) textPoint{

    UIFont *anyFont = [UIFont systemFontOfSize:30.f];
    
    NSShadow *shadowText = [[NSShadow alloc] init];
    shadowText.shadowOffset = CGSizeMake(1, 1);
    shadowText.shadowColor = [UIColor grayColor];
    shadowText.shadowBlurRadius = 1.5;
    
    NSDictionary *fontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor], NSForegroundColorAttributeName,
                                    anyFont, NSFontAttributeName,
                                    shadowText, NSShadowAttributeName, nil];
    
    CGSize textSize = [stringTools sizeWithAttributes:fontAttributes];
    CGRect textRect = CGRectMake(textPoint.x, textPoint.y, textSize.width, textSize.height);
    textRect = CGRectIntegral(textRect);
    
    [stringTools drawInRect:textRect withAttributes:fontAttributes];
}


@end
