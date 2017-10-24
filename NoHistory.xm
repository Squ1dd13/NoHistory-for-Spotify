%hook SPTSearchHistory
//For older versions of Spotify
- (unsigned long long)numberOfSavedSearchStrings {
return 0;
}

%end

//From 8.4.22.515 and up, we need to hide the 'Clear Recent Searches' button and the history.

@interface EXP_SPTSearchRecentsItemComponentView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook EXP_SPTSearchRecentsItemComponentView

-(void)layoutSubviews{

self.hidden = YES;

}

%end

@interface EXP_SPTSearchRecentsClearAllHubComponentView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook EXP_SPTSearchRecentsClearAllHubComponentView

-(void)layoutSubviews{

self.hidden = YES;

}

%end

//Because GLUELabels appear throughout Spotify, find one that says 'Recent searches' and change the text to ' '.

%hook GLUELabel
-(void)setText:(NSString *)arg1{
if([arg1 isEqualToString:@"Recent searches"])
{
%orig(@" ");
} else {
%orig;
}
}
%end

//As an extra, add the NoHistory for Spotify version next to the app version.
//There's probably a way to fetch the app version, but I don't know how so we'll just manually update it.

%hook UITableViewLabel

-(void)setText:(NSString *)arg1{
if([arg1 isEqualToString:@"8.4.22.515"])
{
%orig(@"8.4.22.515/NoHistory 1.3");
} else {
%orig;
}
}
%end
