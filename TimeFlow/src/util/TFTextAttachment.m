//
//  TFTextAttachment.m
//  TimeFlow
//
//  Created by lorabit on 4/12/16.
//
//

#import "TFTextAttachment.h"

@implementation TFTextAttachment

-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
  CGFloat attachmentWidth = CGRectGetWidth(lineFrag) - textContainer.lineFragmentPadding;
  return [self scaleImageSizeToWidth:attachmentWidth];
}

-(CGRect)scaleImageSizeToWidth:(CGFloat)width{
  CGFloat factor = width/self.image.size.width;
  return CGRectMake(0, 0, width, self.image.size.height*factor);
}

@end
