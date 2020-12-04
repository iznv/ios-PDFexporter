//
//  UIImageView+PDFExporterDrawing.m
//  PDFExporter
//
//  Created by Ivan Zinovev on 04.12.2020.
//  Copyright © 2020 3Pillar Global. All rights reserved.
//

#import "UIImageView+PDFExporterDrawing.h"

@implementation UIImageView (PDFExporterDrawing)

- (void)drawContentWithPath:(UIBezierPath *)path {
    CGRect rect = path.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    rect.origin = CGPointZero; // context was translated, there is no need for origin
    
    UIImageView *imageView = (UIImageView *)self;
    UIImage *image = imageView.image;
    
    CGFloat aspect = image.size.width / image.size.height;
    
    CGRect targetRect = rect;
    CGRect newRect;
    
    if (targetRect.size.width / aspect > targetRect.size.height) {
        CGFloat height = targetRect.size.width / aspect;
        
        newRect = CGRectMake(0,
                             (targetRect.size.height - height) / 2,
                             targetRect.size.width,
                             height);
    } else {
        CGFloat width = targetRect.size.height * aspect;
        
        newRect = CGRectMake((targetRect.size.width - width) / 2,
                             0,
                             width,
                             targetRect.size.height);
    }
    
    [image drawInRect:newRect];
    
    CGContextRestoreGState(context);
}

@end
