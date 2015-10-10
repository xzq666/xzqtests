//
//  MyCommentCellTableViewCell.m
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyCommentCell.h"
#import "MyCommentDetailView.h"
#import "MyCommentDetailFrame.h"
#import "MyCommentCellFrame.h"

@implementation MyCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"CommentCell";
    MyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell){
        cell = [[MyCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        // 添加comment内容
        [self setupCommentDetailView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupCommentDetailView{
    MyCommentDetailView *detailView = [[MyCommentDetailView alloc] init];
    [self.contentView addSubview:detailView];
    self.commentDetailView = detailView;
}

- (void)setCommentFrame:(MyCommentCellFrame *)commentFrame {
    _commentFrame = commentFrame;
    self.commentDetailView.commentDetailFrame = commentFrame.commentDetailFrame;
    self.commentDetailView.commentDetailFrame.commentData = commentFrame.commentData;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end