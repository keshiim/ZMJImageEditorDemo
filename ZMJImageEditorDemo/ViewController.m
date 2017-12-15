//
//  ViewController.m
//  ZMJImageEditorDemo
//
//  Created by Jason on 2017/5/11.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "ViewController.h"
#import <ZMJImageEditor/WBGImageEditor.h>
@interface ViewController () <WBGImageEditorDelegate, WBGImageEditorDataSource>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageView = ({
        UIImage *image = [UIImage imageNamed:@"bg" inBundle:[NSBundle bundleForClass:[WBGImageEditor class]] compatibleWithTraitCollection:nil];
        UIImageView *__imageView = [[UIImageView alloc] initWithImage:image];
        __imageView.bounds = self.view.bounds;
        [self.view addSubview:__imageView];
        __imageView;
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        WBGImageEditor *editor = [[WBGImageEditor alloc] initWithImage:_imageView.image delegate:self dataSource:self];
        [self presentViewController:editor animated:YES completion:nil];
    }
}

#pragma mark - WBGImageEditorDelegate
- (void)imageEditor:(WBGImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image {
    self.imageView.image = image;
    [editor.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageEditorDidCancel:(WBGImageEditor *)editor {
    
}

#pragma mark - WBGImageEditorDataSource
- (NSArray<WBGMoreKeyboardItem *> *)imageItemsEditor:(WBGImageEditor *)editor {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
