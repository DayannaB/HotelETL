/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     06/08/22 10:50:06 PM                         */
/*==============================================================*/


/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLIENTEID            SERIAL               not null,
   NOMBRE               VARCHAR(50)          not null,
   CIUDAD               VARCHAR(100)         not null,
   GENERO               VARCHAR(23)          not null,
   constraint PK_CLIENTE primary key (CLIENTEID)
);

/*==============================================================*/
/* Index: CLIENTE_PK                                            */
/*==============================================================*/
create unique index CLIENTE_PK on CLIENTE (
CLIENTEID
);

/*==============================================================*/
/* Table: ESTANCIA                                              */
/*==============================================================*/
create table ESTANCIA (
   CLIENTEID            INT4                 null,
   PAGOID               INT4                 null,
   TIEMPOID             INT4                 null,
   HABITACIONID         INT4                 null,
   PRECIO               DECIMAL(8,2)         not null
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_1_FK on ESTANCIA (
CLIENTEID
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_2_FK on ESTANCIA (
PAGOID
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_3_FK on ESTANCIA (
TIEMPOID
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_4_FK on ESTANCIA (
HABITACIONID
);

/*==============================================================*/
/* Table: HABITACION                                            */
/*==============================================================*/
create table HABITACION (
   HABITACIONID         SERIAL               not null,
   TIPO                 VARCHAR(50)          not null,
   NUMERO               VARCHAR(4)           not null,
   constraint PK_HABITACION primary key (HABITACIONID)
);

/*==============================================================*/
/* Index: HABITACION_PK                                         */
/*==============================================================*/
create unique index HABITACION_PK on HABITACION (
HABITACIONID
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO (
   PAGOID               SERIAL               not null,
   TIPO                 VARCHAR(50)          not null,
   constraint PK_PAGO primary key (PAGOID)
);

/*==============================================================*/
/* Index: PAGO_PK                                               */
/*==============================================================*/
create unique index PAGO_PK on PAGO (
PAGOID
);

/*==============================================================*/
/* Table: TIEMPO                                                */
/*==============================================================*/
create table TIEMPO (
   TIEMPOID             SERIAL               not null,
   FECHA                DATE                 not null,
   ANO                  INT4                 not null,
   TRIMESTRE            INT4                 not null,
   MES                  VARCHAR(20)          not null,
   DIA                  INT4                 not null,
   constraint PK_TIEMPO primary key (TIEMPOID)
);

/*==============================================================*/
/* Index: TIEMPO_PK                                             */
/*==============================================================*/
create unique index TIEMPO_PK on TIEMPO (
TIEMPOID
);

alter table ESTANCIA
   add constraint FK_ESTANCIA_RELATIONS_CLIENTE foreign key (CLIENTEID)
      references CLIENTE (CLIENTEID)
      on delete restrict on update restrict;

alter table ESTANCIA
   add constraint FK_ESTANCIA_RELATIONS_PAGO foreign key (PAGOID)
      references PAGO (PAGOID)
      on delete restrict on update restrict;

alter table ESTANCIA
   add constraint FK_ESTANCIA_RELATIONS_TIEMPO foreign key (TIEMPOID)
      references TIEMPO (TIEMPOID)
      on delete restrict on update restrict;

alter table ESTANCIA
   add constraint FK_ESTANCIA_RELATIONS_HABITACI foreign key (HABITACIONID)
      references HABITACION (HABITACIONID)
      on delete restrict on update restrict;

