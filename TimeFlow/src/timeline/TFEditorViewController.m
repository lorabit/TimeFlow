//
//  TFEditorViewController.m
//  TimeFlow
//
//  Created by lorabit on 4/12/16.
//
//

#import "TFEditorViewController.h"
#import "TFTextAttachment.h"

@implementation TFEditorViewController{
  UITextView* editorView;
  TFTextAttachment* attachedImg;
}


-(void)viewDidLoad{
  [super viewDidLoad];
  [self configureUIAppearance];
}

-(void)configureUIAppearance{
  [super configureUIAppearance];
  editorView = [[UITextView alloc] init];
  [self.view addSubview:editorView];
  
  [editorView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
  
  
  NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"test"];
 attachedImg = [[TFTextAttachment alloc] init];
  attachedImg.image = [UIImage imageWithRenderColor:[UIColor colorWithHex:0x333333] renderSize:CGSizeMake(50, 50)];
  [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
  [str appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachedImg]];
  [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
  [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"dwgklodsfjhgefrilohgofglkhjf\nsdfgoihsdgohd"]];
  
  NSLog(@"%@",[self paragraphsForAttributedString:str].debugDescription);
  editorView.attributedText = str;
  [self performSelector:@selector(delay) withObject:nil afterDelay:1];
  NSLog(@"%f",[str boundingRectWithSize:CGSizeMake(200, 200) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
}

-(void)delay{
  
  attachedImg.image = [UIImage imageNamed:@"img"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [editorView.layoutManager invalidateLayoutForCharacterRange:NSMakeRange(0, editorView.attributedText.length) actualCharacterRange:NULL];
  });
  
  NSLog(@"%f",[editorView.attributedText boundingRectWithSize:CGSizeMake(200, 200) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
}

- (NSArray *)paragraphsForAttributedString:(NSAttributedString *)input {
  NSMutableArray *paragraphs = [NSMutableArray array];
  
  NSUInteger length = [input length];
  NSUInteger paraStart = 0, paraEnd = 0, contentsEnd = 0;
  NSRange currentRange;
  while (paraEnd < length) {
    [input.string getParagraphStart:&paraStart end:&paraEnd
                        contentsEnd:&contentsEnd forRange:NSMakeRange(paraEnd, 0)];
    currentRange = NSMakeRange(paraStart, contentsEnd - paraStart);
    if (currentRange.length > 0)
      [paragraphs addObject:[input attributedSubstringFromRange:currentRange]];
    else
      [paragraphs addObject:[[NSAttributedString alloc] init]];
  }
  
  return paragraphs;
}

@end
