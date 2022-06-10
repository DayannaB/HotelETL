Select cl1.clienteid, pa1.pagoid, ti1.tiempoid, ha1.habitacionid, f1.valortotal
from estancia as e1 inner join habitacion as h1 on e1.idhabitacion = h1.idhabitacion
					inner join huesped as h2 on e1.idhuesped = h2.idhuesped
					inner join factura as f1 on e1.idfactura = f1.idfactura
					inner join dblink('host=localhost dbname=Datamart user=daya password=123456',
							   $$ SELECT habitacionid, numero FROM habitacion $$) AS ha1 
							   (habitacionid int, numero varchar(4) ) ON h1.numerohabitacion = ha1.numero
					inner join dblink('host=localhost dbname=Datamart user=daya password=123456',
							   $$ SELECT clienteid, nombre FROM cliente $$) AS cl1 
							   (clienteid int, nombre varchar(50) ) ON h2.nombrehuesped = cl1.nombre
					inner join dblink('host=localhost dbname=Datamart user=daya password=123456',
							   $$ SELECT pagoid, tipo FROM pago $$) AS pa1 
							   (pagoid int, tipo varchar(50) ) ON f1.tipofactura = pa1.tipo
					inner join dblink('host=localhost dbname=Datamart user=daya password=123456',
							   $$ SELECT tiempoid, fecha FROM tiempo $$) AS ti1 
							   (tiempoid int, fecha date ) ON f1.fechafactura = ti1.fecha