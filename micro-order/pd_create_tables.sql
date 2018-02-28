/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/1/26 11:18:23                           */
/*==============================================================*/


drop table if exists orders;

drop table if exists orders_assignlog;

drop table if exists orders_product;

drop table if exists orders_product_detail;

drop table if exists orders_statuslog;

drop table if exists shoppingcart;

drop table if exists shoppingcart_detail;

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   id                   int not null auto_increment,
   order_number         varchar(50),
   flow_type            int comment '流程类型（1：非固定克重，2：固定克重）',
   customer_id          int,
   customer_account_id  int,
   customer_name        varchar(100),
   principal_sale_id    int,
   order_handler_sale_id int,
   order_status         int,
   company_id           int,
   delete_flg           int comment '删除标志（0：正常，1：客户删除，2：销售删除）',
   create_time          datetime,
   primary key (id)
);

alter table orders comment '订单';

/*==============================================================*/
/* Table: orders_assignlog                                      */
/*==============================================================*/
create table orders_assignlog
(
   id                   int not null auto_increment,
   orders_id            int not null,
   principal_sale_id    int,
   assign_sale_id       int,
   op_account_id        int,
   create_time          datetime,
   primary key (id)
);

alter table orders_assignlog comment '订单指派日志';

/*==============================================================*/
/* Table: orders_product                                        */
/*==============================================================*/
create table orders_product
(
   id                   int not null auto_increment,
   orders_id            int,
   product_id           int,
   product_name         varchar(100),
   attr_json            varchar(1000),
   is_details           int,
   create_time          datetime,
   remark               varchar(500),
   primary key (id)
);

alter table orders_product comment '订单-产品';

/*==============================================================*/
/* Table: orders_product_detail                                 */
/*==============================================================*/
create table orders_product_detail
(
   id                   int not null auto_increment,
   orders_id            int,
   orders_product_id    int,
   specification_josn   varchar(500),
   count                int,
   product_weight       double,
   shipment_weight      double,
   create_time          datetime,
   primary key (id)
);

alter table orders_product_detail comment '订单-产品-详情';

/*==============================================================*/
/* Table: orders_statuslog                                      */
/*==============================================================*/
create table orders_statuslog
(
   id                   int not null auto_increment,
   orders_id            int not null,
   before_change        int,
   after_change         int,
   op_account_id        int,
   create_time          datetime,
   primary key (id)
);

alter table orders_statuslog comment '订单状态日志';

/*==============================================================*/
/* Table: shoppingcart                                          */
/*==============================================================*/
create table shoppingcart
(
   id                   int not null auto_increment,
   customer_account_id  int,
   product_id           int,
   product_name         varchar(100),
   is_details           int,
   company_id           int,
   create_time          datetime,
   primary key (id)
);

alter table shoppingcart comment '购物车';

/*==============================================================*/
/* Table: shoppingcart_detail                                   */
/*==============================================================*/
create table shoppingcart_detail
(
   id                   int not null auto_increment,
   shoppingcart_id      int,
   product_id           int,
   attr_json            varchar(500),
   specification_josn   varchar(500),
   remark               varchar(500),
   count                int,
   product_weight       double,
   shipment_weight      double,
   create_time          date,
   primary key (id)
);

alter table shoppingcart_detail comment '购物车-产品详情';

alter table orders_product add constraint FK_Reference_3 foreign key (orders_id)
      references orders (id) on delete restrict on update restrict;

alter table orders_product_detail add constraint FK_Reference_5 foreign key (orders_product_id)
      references orders_product (id) on delete restrict on update restrict;

alter table shoppingcart_detail add constraint FK_Reference_4 foreign key (shoppingcart_id)
      references shoppingcart (id) on delete restrict on update restrict;

