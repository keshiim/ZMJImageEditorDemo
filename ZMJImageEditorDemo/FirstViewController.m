//
//  FirstViewController.m
//  ZMJImageEditorDemo
//
//  Created by Jason on 2017/12/28.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "FirstViewController.h"
#import <ZMJImageEditor/WBGImageEditor.h>
#import <ZMJImageEditor/WBGImageEditorViewController.h>

@interface FirstViewController () <WBGImageEditorDelegate, WBGImageEditorDataSource>
@property (weak, nonatomic) IBOutlet UIView *containerVIew;
@property (strong, nonatomic) WBGImageEditor *editor;
@end

@implementation FirstViewController
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImage *image = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.containerVIew.bounds.size.width, self.containerVIew.bounds.size.height)];
    
    self.editor = [[WBGImageEditor alloc] initWithImage:image delegate:self dataSource:self];
    self.editor.needHiddenBars = YES;
    self.editor.view.frame = self.containerVIew.bounds;
    [self addChildViewController:self.editor];
    [self.containerVIew addSubview:self.editor.view];
    [self.editor didMoveToParentViewController:self];
}

#pragma mark - WBGImageEditorDelegate
- (void)imageEditor:(WBGImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image {
    
    [editor.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageEditorDidCancel:(WBGImageEditor *)editor {
    
}

#pragma mark - WBGImageEditorDataSource
- (NSArray<WBGMoreKeyboardItem *> *)imageItemsEditor:(WBGImageEditor *)editor {
    return nil;
}

- (WBGImageEditorComponent)imageEditorCompoment {
    return WBGImageEditorWholeComponent;
}

- (NSNumber *)imageEditorDrawPathWidth {
    return @(5.f);
}

- (UIColor *)imageEditorDefaultColor {
    return UIColor.redColor;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)undo:(id)sender {
    [self.editor undoAll];
}
- (IBAction)save:(id)sender {
    [self.editor sendAction:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
