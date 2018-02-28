/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/1/26 10:23:10                           */
/*==============================================================*/


drop table if exists account;

drop table if exists account_name;

drop table if exists account_token;

drop table if exists account_volid_app;

drop table if exists authitem;

drop table if exists authitem_btn;

drop table if exists authitem_menu;

drop table if exists menu;

drop table if exists menu_btn;

drop table if exists postion_authitem;

drop table if exists role;

drop table if exists role_authitem;

/*==============================================================*/
/* Table: account                                               */
/*==============================================================*/
create table account
(
   id                   int not null auto_increment comment '主键',
   account_type         int not null comment '账号类型(1:客户，2:销售)',
   password             varchar(50) not null,
   role_id              varchar(100) comment '角色id（多个用逗号隔开）',
   jobtitle_id          varchar(100) comment '职位id（多个用逗号隔开）',
   status               int not null comment '状态（0：正常，1：禁用）',
   company_id           int,
   create_time          datetime,
   primary key (id)
)
auto_increment = 100000;

alter table account comment '账号';

/*==============================================================*/
/* Table: account_name                                          */
/*==============================================================*/
create table account_name
(
   id                   int not null auto_increment,
   account_id           int not null,
   account_name         varchar(50) not null,
   type                 varchar(50) not null comment '如：邮箱、手机、注册账号',
   company_id           int comment '公司id',
   create_time          datetime not null,
   primary key (id)
);

alter table account_name comment '账号名';

/*==============================================================*/
/* Table: account_token                                         */
/*==============================================================*/
create table account_token
(
   id                   int not null auto_increment,
   account_id           int,
   app_id               varchar(50),
   access_token         varchar(50),
   access_token_expires int,
   refresh_token        varchar(50),
   refresh_token_expires int,
   create_time          datetime,
   primary key (id)
);

alter table account_token comment '账号token';

/*==============================================================*/
/* Table: account_volid_app                                     */
/*==============================================================*/
create table account_volid_app
(
   id                   int not null,
   account_id           int,
   volid_app_id         int,
   create_time          datetime,
   primary key (id)
);

/*==============================================================*/
/* Table: authitem                                              */
/*==============================================================*/
create table authitem
(
   id                   int not null auto_increment,
   auth_item_name       varchar(50),
   create_time          datetime,
   primary key (id)
);

alter table authitem comment '权限项';

/*==============================================================*/
/* Table: authitem_btn                                          */
/*==============================================================*/
create table authitem_btn
(
   id                   int not null auto_increment,
   role_id              int,
   btn_id               int,
   create_time          datetime,
   primary key (id)
);

alter table authitem_btn comment '权限项-按钮';

/*==============================================================*/
/* Table: authitem_menu                                         */
/*==============================================================*/
create table authitem_menu
(
   id                   int not null auto_increment,
   role_id              int,
   menu_id              int,
   create_time          datetime,
   primary key (id)
);

alter table authitem_menu comment '权限项-菜单';

/*==============================================================*/
/* Table: menu                                                  */
/*==============================================================*/
create table menu
(
   id                   int not null auto_increment,
   menu_name            varchar(50),
   menu_url             varchar(100) comment '菜单url(仅用于前端)',
   company_id           int,
   parent_id            int,
   create_time          datetime,
   primary key (id)
);

alter table menu comment '菜单';

/*==============================================================*/
/* Table: menu_btn                                              */
/*==============================================================*/
create table menu_btn
(
   id                   int not null auto_increment,
   btn_name             varchar(50),
   btn_class            varchar(50) comment '按钮class(用于控制页面按钮是否显示)',
   menu_id              int,
   company_id           int,
   create_time          datetime,
   primary key (id)
);

alter table menu_btn comment '菜单-按钮';

/*==============================================================*/
/* Table: postion_authitem                                      */
/*==============================================================*/
create table postion_authitem
(
   id                   int not null auto_increment,
   jobtitle_id          int,
   auth_item_id         int,
   create_time          datetime,
   primary key (id)
);

alter table postion_authitem comment '职位-权限项目';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   id                   int not null auto_increment,
   role_name            varchar(50),
   create_time          datetime,
   primary key (id)
);

alter table role comment '角色';

/*==============================================================*/
/* Table: role_authitem                                         */
/*==============================================================*/
create table role_authitem
(
   id                   int not null auto_increment,
   auth_item_id         int,
   create_time          datetime,
   primary key (id)
);

alter table role_authitem comment '角色-权限项';

alter table account_name add constraint FK_Reference_1 foreign key (account_id)
      references account (id) on delete restrict on update restrict;

alter table account_volid_app add constraint FK_Reference_8 foreign key (account_id)
      references account (id) on delete restrict on update restrict;

alter table menu_btn add constraint FK_Reference_6 foreign key (id)
      references menu (id) on delete restrict on update restrict;

