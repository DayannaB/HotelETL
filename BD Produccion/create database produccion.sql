/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     06/08/22 1:31:23 AM                          */
/*==============================================================*/


/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   IDEMPLEADO           INT4                 not null,
   NOMBREEMPLEADO       VARCHAR(50)          null,
   TIPOEMPLEADO         VARCHAR(50)          null,
   CEDULAEMPLEADO       VARCHAR(13)          null,
   FECHANACIMIENTOEMPLEADO DATE                 null,
   DIRECCIONEMPLEADO    VARCHAR(60)          null,
   GENEROEMPLEADO       VARCHAR(23)          null,
   TELEFONOEMPLEADO     VARCHAR(23)          null,
   constraint PK_EMPLEADO primary key (IDEMPLEADO)
);

/*==============================================================*/
/* Index: EMPLEADO_PK                                           */
/*==============================================================*/
create unique index EMPLEADO_PK on EMPLEADO (
IDEMPLEADO
);

/*==============================================================*/
/* Table: ESTANCIA                                              */
/*==============================================================*/
create table ESTANCIA (
   IDALOJAMIENTO        INT4                 not null,
   IDHUESPED            INT4                 null,
   IDFACTURA            INT4                 null,
   IDHABITACION         INT4                 null,
   FECHAINICIOALOJAMIENTO DATE                 null,
   FECHAFINALALOJAMIENTO DATE                 null,
   FORMADEPAGO          VARCHAR(50)          null,
   COSTOALOJAMIENTO     DECIMAL(8,2)         null,
   constraint PK_ESTANCIA primary key (IDALOJAMIENTO)
);

/*==============================================================*/
/* Index: ESTANCIA_PK                                           */
/*==============================================================*/
create unique index ESTANCIA_PK on ESTANCIA (
IDALOJAMIENTO
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_4_FK on ESTANCIA (
IDHUESPED
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_5_FK on ESTANCIA (
IDFACTURA
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_9_FK on ESTANCIA (
IDHABITACION
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   IDFACTURA            INT4                 not null,
   IDHUESPED            INT4                 null,
   TIPOFACTURA          VARCHAR(50)          null,
   VALORTOTAL           DECIMAL(8,2)         null,
   SUBTOTAL             DECIMAL(8,2)         null,
   IVA                  DECIMAL(8,2)         null,
   FECHAFACTURA         DATE                 null,
   constraint PK_FACTURA primary key (IDFACTURA)
);

/*==============================================================*/
/* Index: FACTURA_PK                                            */
/*==============================================================*/
create unique index FACTURA_PK on FACTURA (
IDFACTURA
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_7_FK on FACTURA (
IDHUESPED
);

/*==============================================================*/
/* Table: HABITACION                                            */
/*==============================================================*/
create table HABITACION (
   IDHABITACION         INT4                 not null,
   TIPOHABITACION       VARCHAR(50)          null,
   NUMEROHABITACION     VARCHAR(4)           null,
   CAPACIDADHABITACION  INT2                 null,
   constraint PK_HABITACION primary key (IDHABITACION)
);

/*==============================================================*/
/* Index: HABITACION_PK                                         */
/*==============================================================*/
create unique index HABITACION_PK on HABITACION (
IDHABITACION
);

/*==============================================================*/
/* Table: HUESPED                                               */
/*==============================================================*/
create table HUESPED (
   IDHUESPED            INT4                 not null,
   NOMBREHUESPED        VARCHAR(50)          null,
   GENEROHUESPED        VARCHAR(23)          null,
   CEDULAHUESPED        VARCHAR(13)          null,
   TELEFONOHUESPED      VARCHAR(23)          null,
   CIUDADHUESPED        VARCHAR(100)         null,
   EMAILHUESPED         VARCHAR(100)         null,
   constraint PK_HUESPED primary key (IDHUESPED)
);

/*==============================================================*/
/* Index: HUESPED_PK                                            */
/*==============================================================*/
create unique index HUESPED_PK on HUESPED (
IDHUESPED
);

/*==============================================================*/
/* Table: MANTENIMIENTO                                         */
/*==============================================================*/
create table MANTENIMIENTO (
   IDMANTENIMIENTO      INT4                 not null,
   IDHABITACION         INT4                 null,
   IDEMPLEADO           INT4                 null,
   FECHAMANTENIMIENTO   DATE                 null,
   TIPOMANTENIMIENTO    VARCHAR(50)          null,
   constraint PK_MANTENIMIENTO primary key (IDMANTENIMIENTO)
);

/*==============================================================*/
/* Index: MANTENIMIENTO_PK                                      */
/*==============================================================*/
create unique index MANTENIMIENTO_PK on MANTENIMIENTO (
IDMANTENIMIENTO
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_10_FK on MANTENIMIENTO (
IDHABITACION
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_8_FK on MANTENIMIENTO (
IDEMPLEADO
);

/*==============================================================*/
/* Table: PROVEEDOR                                             */
/*==============================================================*/
create table PROVEEDOR (
   IDPROVEEDOR          INT4                 not null,
   NOMBREPROVEEDOR      VARCHAR(100)         null,
   TIPOPROVEEDOR        VARCHAR(50)          null,
   TELEFONOPROVEEDOR    VARCHAR(20)          null,
   PAGINAWEB            VARCHAR(200)         null,
   DIRECCIONPROVEEDOR   VARCHAR(100)         null,
   constraint PK_PROVEEDOR primary key (IDPROVEEDOR)
);

/*==============================================================*/
/* Index: PROVEEDOR_PK                                          */
/*==============================================================*/
create unique index PROVEEDOR_PK on PROVEEDOR (
IDPROVEEDOR
);

/*==============================================================*/
/* Table: SERVICIOS                                             */
/*==============================================================*/
create table SERVICIOS (
   ID_SERVICIO          INT4                 not null,
   IDEMPLEADO           INT4                 null,
   TIPODEPAGOSERVICIO   VARCHAR(23)          null,
   TIPOSERVICIO         VARCHAR(23)          null,
   constraint PK_SERVICIOS primary key (ID_SERVICIO)
);

/*==============================================================*/
/* Index: SERVICIOS_PK                                          */
/*==============================================================*/
create unique index SERVICIOS_PK on SERVICIOS (
ID_SERVICIO
);

/*==============================================================*/
/* Index: RELATIONSHIP_11_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_11_FK on SERVICIOS (
IDEMPLEADO
);

alter table ESTANCIA
   add constraint FK_ESTANCIA_RELATIONS_HUESPED foreign key (IDHUESPED)
      references HUESPED (IDHUESPED)
      on delete restrict on update restrict;

alter table ESTANCIA
   add constraint FK_ESTANCIA_RELATIONS_FACTURA foreign key (IDFACTURA)
      references FACTURA (IDFACTURA)
      on delete restrict on update restrict;

alter table ESTANCIA
   add constraint FK_ESTANCIA_RELATIONS_HABITACI foreign key (IDHABITACION)
      references HABITACION (IDHABITACION)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_RELATIONS_HUESPED foreign key (IDHUESPED)
      references HUESPED (IDHUESPED)
      on delete restrict on update restrict;

alter table MANTENIMIENTO
   add constraint FK_MANTENIM_RELATIONS_HABITACI foreign key (IDHABITACION)
      references HABITACION (IDHABITACION)
      on delete restrict on update restrict;

alter table MANTENIMIENTO
   add constraint FK_MANTENIM_RELATIONS_EMPLEADO foreign key (IDEMPLEADO)
      references EMPLEADO (IDEMPLEADO)
      on delete restrict on update restrict;

alter table SERVICIOS
   add constraint FK_SERVICIO_RELATIONS_EMPLEADO foreign key (IDEMPLEADO)
      references EMPLEADO (IDEMPLEADO)
      on delete restrict on update restrict;

