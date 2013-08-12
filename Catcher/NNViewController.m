//
//  NNViewController.m
//  Catcher
//
//  Created by Moshe Berman on 8/12/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "NNViewController.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@interface NNViewController ()

@end

@implementation NNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
		
}

- (void)viewDidAppear:(BOOL)animated {
		[super viewDidAppear:animated];
		
		[self checkVisibleRect:nil];
		
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkVisibleRect:(id)sender {
		
		//	The most obvious place to look is the main window
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		NSLog(@"window: %@", window);
		
		//	The window's superview is nil
		UIView *windowParent = window.superview;
		NSLog(@"windowParent: %@", windowParent);
		
		//	Get the window's layer's superlayer
		CALayer *layer = window.layer.superlayer;
		
		NSLog(@"Layer: %@", layer);
		
		//	Look at it's visible rect
		CGRect rect = [layer visibleRect];
		
		NSString *visibleRectString = NSStringFromCGRect(rect);
		
		NSLog(@"Rect: %@", visibleRectString);
		
		// Looks like that never changes...
		NSArray *layers = layer.sublayers;
		
		NSLog(@"layers: %@", layers);
		
		//	Nope, that's only got our view's layer,
		//	so let's try something else.
		
		id layerDelegate = layer.delegate;
		
		NSLog(@"LayerDelegate: %@", layerDelegate);
		NSLog(@"Class: %@", NSStringFromClass([layerDelegate class]));
		
		// What about the window's layer's visible rect?
		
		CGRect windowVisibleRect = window.layer.visibleRect;
		NSString *windowVisibleRectString = NSStringFromCGRect(windowVisibleRect);
		
		NSLog(@"Window Visible Rect: %@", windowVisibleRectString);
		
		//	Root view controller view layer?
		UIViewController *rootViewController = window.rootViewController;
		
		CGRect viewVisibleRect = rootViewController.view.layer.visibleRect;
		NSString *viewVisibleRectString = NSStringFromCGRect(viewVisibleRect);
		
		NSLog(@"Visible Rect: %@", viewVisibleRectString);
		
		//	Application frame?
		CGRect screen = [[UIScreen mainScreen] applicationFrame];
		NSString *screenString = NSStringFromCGRect(screen);
		
		NSLog(@"Screen: %@", screenString);
		
		//	Try grabbing the application's color
		UIView *view = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
		NSLog(@"View: %@", view);
		
		
}

- (IBAction)takeScreenshot:(id)sender
{
		
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		UIGraphicsBeginImageContext(window.bounds.size);
		[window.layer renderInContext:UIGraphicsGetCurrentContext()];
		UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}

@end
