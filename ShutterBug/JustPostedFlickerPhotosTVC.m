//
//  JustPostedFlickerPhotosTVC.m
//  ShutterBug
//
//  Created by Ikjot singh on 9/13/17.
//  Copyright © 2017 Ikjot singh. All rights reserved.
//

#import "JustPostedFlickerPhotosTVC.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickerPhotosTVC ()

@end

@implementation JustPostedFlickerPhotosTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPhotos];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refresh:(id)sender {
}
////
//
///
//
//
-(IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_queue_t fetchQ = dispatch_queue_create( "flicker fetcher", NULL);
    dispatch_async(fetchQ , ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization  JSONObjectWithData:jsonResults options:0 error:NULL];
        
        NSLog(@"Flicker resylts = %@", propertyListResults);
        NSArray *photoArray = [propertyListResults valueForKeyPath: FLICKR_RESULTS_PHOTOS];  // photos.photo ... here photo is inbuilt function;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
             self.photos = photoArray;
        });
    });
   
    
}
//
//
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
