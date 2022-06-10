--dimension habitacion
select distinct tipohabitacion, numerohabitacion from habitacion
--dimension cliente
select distinct nombrehuesped, generohuesped, ciudadhuesped from huesped
--dimension pago
select distinct tipofactura from factura
--dimension tiempo
select distinct 
TO_DATE( cast(fechafactura as text),'YYYY-MM-DD') as fecha
,extract(year from fechafactura) as anio
,extract(quarter from fechafactura) as trimestre
,extract(month from fechafactura) as mes
,extract(day from fechafactura) as dia 
from factura




