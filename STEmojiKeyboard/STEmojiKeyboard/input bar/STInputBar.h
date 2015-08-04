//
//  STInputBar.h
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STInputBar : UIView

+ (instancetype)inputBar;

@property (assign, nonatomic) BOOL fitWhenKeyboardShowOrHide;
@property (strong, nonatomic) UITextView *textView;

- (void)setDidSendClicked:(void(^)(NSString *text))handler;

@property (copy, nonatomic) NSString *placeHolder;

- (void)setInputBarSizeChangedHandle:(void(^)())handler;

@end
