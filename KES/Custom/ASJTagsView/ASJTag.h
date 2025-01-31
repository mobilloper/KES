//
// ASJTag.h
//
// Copyright (c) 2016 Sudeep Jaiswal
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef void (^TagBlock)(NSString *tagText, NSInteger idx);

@interface ASJTag : UIView

/**
 *  The tag's text.
 */
@property (nullable, copy, nonatomic) NSString *tagText;

/**
 *  Text color for tags' strings.
 */
@property (nullable, strong, nonatomic) UIColor *tagTextColor;

/**
 *  Set a custom image for the delete button.
 */
@property (nullable, strong, nonatomic) UIImage *crossImage;

/**
 *  Font for the tags' text.
 */
@property (nullable, assign, nonatomic) UIFont *tagFont;

/**
 *  A block to handle taps on the tags.
 */
@property (nullable, copy) TagBlock tapBlock;

/**
 *  A block that executes when the 'cross' is tapped to delete a tag.
 */
@property (nullable, copy) TagBlock deleteBlock;

- (void)setTapBlock:(TagBlock _Nullable)tapBlock;
- (void)setDeleteBlock:(TagBlock _Nullable)deleteBlock;

@end

NS_ASSUME_NONNULL_END
