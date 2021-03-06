//
//  NLWeiboTableViewCell.m
//  Neverland
//
//  Created by Rake Yang on 2019/11/1.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NLWeiboTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "WBImageGroupView.h"

@interface NLWeiboTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *avatorView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *sourceLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, strong) IBOutlet WBImageGroupView *imageGroupView;


@property (nonatomic, strong) NLWBStatusViewModel *viewModel;


@end

@implementation NLWeiboTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatorView.layer.cornerRadius = 40/2.0;
    self.avatorView.layer.masksToBounds = YES;
}

- (void)fillWithViewModel:(NLWBStatusViewModel *)viewModel {
    _viewModel = viewModel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.avatorView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.avatar]];
    self.nameLabel.text = self.viewModel.screen_name;
    self.timeLabel.text = self.viewModel.createdStr;
    self.sourceLabel.text = self.viewModel.source;
    self.contentLabel.text = self.viewModel.text;
    self.thumbnailImageView.hidden = !self.viewModel.picURL;
    self.imageGroupView.hidden = self.viewModel.picURLs.count <= 1;
    if (self.viewModel.picURLs.count > 1) {
        //九宫格模式
        self.imageGroupView.frame = CGRectMake(self.avatorView.mcLeft, self.contentLabel.mcBottom+8, self.viewModel.imageGroupSize.width, self.viewModel.imageGroupSize.height);
        [self.imageGroupView fillWithImageURLs:self.viewModel.picURLs];
    } else {
        //单张图片
        if (!self.thumbnailImageView.hidden) {
            [self.thumbnailImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentLabel);
                make.top.equalTo(self.contentLabel.mas_bottom).offset(8);
                make.size.mas_equalTo(adjustSizeWithLimit(self.viewModel.picSize, CGSizeMake(288, 256)));
            }];
            [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.picURL] placeholderImage:self.thumbnailImageView.image];
        }
    }
}

+ (CGFloat)defaultHeightForData:(NLWBStatusViewModel *)data {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 4;
    paragraph.minimumLineHeight = 20;
    
    CGFloat contentHeight = 16 + 40 + 16;
    
    if (data.text.length) {
        CGFloat textH = [data.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 16*2, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraph} context:nil].size.height;
        contentHeight += MIN(textH, 8*24);
    }
    
    if (data.picSize.height > 0) {
        contentHeight += 8 + data.picSize.height;
    }
    
    if (data.picURLs.count > 1) {
        contentHeight += 8 + data.imageGroupSize.height;
    }
    
    contentHeight += 16;
    return contentHeight;
}

@end
