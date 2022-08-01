
<?php
$conexion=pg_connect("host=localhost dbname=datamart_hotel user=postgres password=12345");

?> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hotel DAMIFRA</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
</head>
<body>
	<div class="container py-4 py-xl-5">
		<div class="row mb-5">
			<div class="col-md-8 col-xl-6 text-center mx-auto">
				<h2>HOTEL DAMIFRA</h2>
				<p class="w-lg-50">Sistema ETL del hotel "DAMIFRA"</p>
			</div>
		</div>
		<div class="row gy-4 row-cols-1 row-cols-md-2 row-cols-xl-3">
			<div class="col">
				<div p-4>
					<span class="btn badge rounded-pill bg-primary mb-2" onclick="CargarDatosGraficoBar()">Gráfico</span>
					<h4>Gráfico #1</h4>
					<canvas id="myChart"></canvas>
					<div class="d-flex">
						<p>Muestra los distintos generos de los clientes que han ocupado una estadia en el hotel.</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div p-4>
					<span class="btn badge rounded-pill bg-primary mb-2" onclick="CargarDatosGraficoBar2()">Gráfico</span>
					<h4 >Gráfico #2</h4>
					<canvas id="myChart2"></canvas>
					<div class="d-flex">
						<p>Muestra de cuantos cliente en los meses del año 2022</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div p-4>
					<span class="btn badge rounded-pill bg-primary mb-2" onclick="CargarDatosGraficoBar3()">Gráfico</span>
					<h4>Gráfico #3</h4>
					<canvas id="myChart3"></canvas>
					<div class="d-flex">
						<p>Muestra las cantidades de clientes que han pagado con cheques, efectivo y tarjeta.	</p>
					</div>
				</div>
			</div>
		</div>
	</div>
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<h3 class="text-center">Tabla de estancias</h3>
			              <table class="table table-hover"  >
                <thead>
                  <tr>
                    <th>Numero Estancia</th>
                    <th>Nombre Cliente</th>
                    <th>Habitacion</th>
                    <th>Fecha de la estadia</th>
                    <th>Tipo de Pago</th>
                  </tr>
              </thead>
              <tbody>
                <?php 
                  $sql="SELECT id_estancia, nombre, numero, fecha, tipo FROM estancia INNER JOIN cliente ON cliente.clienteid = estancia.clienteid INNER JOIN habitacion ON habitacion.habitacionid = estancia.habitacionid INNER JOIN tiempo ON tiempo.tiempoid = estancia.tiempoid INNER JOIN pago ON pago.pagoid = estancia.pagoid;";
                  $result=pg_query($conexion,$sql);
                  while($obj=pg_fetch_object($result)){
                ?>
                <tr>
                  <td><?php echo $obj->id_estancia;?></td>
                  <td><?php echo $obj->nombre;?></td>
                  <td><?php echo $obj->numero;?></td>
                  <td><?php echo $obj->fecha;?></td>
                  <td><?php echo $obj->tipo;?></td>
                </tr>
              <?php }?>
              </tbody>
              </table>
		</div>
	</div>
	
</div>

</body>
</html>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script type="text/javascript">
    function CargarDatosGraficoBar() {
    	
    
      const ctx = document.getElementById('myChart');
      const myChart = new Chart(ctx, {
          type: 'bar',
          data: {
              labels: [
              <?php
              $sql="SELECT DISTINCT genero FROM cliente INNER JOIN estancia ON cliente.clienteid = estancia.clienteid;";
              $result=pg_query($conexion,$sql);
              while ($registros = pg_fetch_array($result)){
              ?>
              '<?php echo $registros["genero"]?>',
              <?php   
              }
              ?>
              ],
              datasets: [{
                  label: 'Numero de clientes',
                  data: 
                  <?php
                  $sql="SELECT genero, COUNT(genero) AS total FROM cliente INNER JOIN estancia ON cliente.clienteid = estancia.clienteid GROUP BY genero;";
                  $result = pg_query($conexion,$sql);
                  ?>
                  [<?php while ($registros = pg_fetch_array($result)) {
                  ?>
                  <?php echo $registros["total"]?>, 
                  <?php } ?>
                  ],
                  backgroundColor: [
                      'rgba(255, 99, 132, 0.2)',
                      'rgba(54, 162, 235, 0.2)',
                      'rgba(255, 206, 86, 0.2)',
                      
                      'rgba(153, 102, 255, 0.2)',
                      'rgba(255, 159, 64, 0.2)'
                  ],
                  borderColor: [
                      'rgba(255, 99, 132, 1)',
                      'rgba(54, 162, 235, 1)',
                      'rgba(255, 206, 86, 1)',
                      
                      'rgba(153, 102, 255, 1)',
                      'rgba(255, 159, 64, 1)'
                  ],
                  borderWidth: 1
              }]
          },
          options: {
              scales: {
                  y: {
                      beginAtZero: true
                  }
              }
          }
      });
}

    function CargarDatosGraficoBar2() {
    	
    
      const ctx = document.getElementById('myChart2');
      const myChart = new Chart(ctx, {
          type: 'pie',
          data: {
              labels: ['Marzo','Febrero', 'Enero', 'Abril', 'Junio', 'Mayo' ],
              datasets: [{
                  label: 'Numero de clientes',
                  data: 
                  <?php
                  $sql="SELECT DISTINCT EXTRACT(MONTH FROM fecha) AS fecha_meses, COUNT(EXTRACT(MONTH FROM fecha)) AS total FROM tiempo INNER JOIN estancia ON tiempo.tiempoid = estancia.tiempoid GROUP BY fecha_meses;";
                  $result = pg_query($conexion,$sql);
                  ?>
                  [<?php while ($registros = pg_fetch_array($result)) {
                  ?>
                  <?php echo $registros["total"]?>, 
                  <?php } ?>
                  ],
                  backgroundColor: [
                      'rgba(255, 99, 132, 0.2)',
                      'rgba(54, 162, 235, 0.2)',
                      'rgba(255, 206, 86, 0.2)',  
                      'rgba(153, 102, 255, 0.2)',
                      'rgba(255, 159, 64, 0.2)',
                      'rgba(100, 200, 50, 0.2)'
                  ],
                  borderColor: [
                      'rgba(255, 99, 132, 1)',
                      'rgba(54, 162, 235, 1)',
                      'rgba(255, 206, 86, 1)',
                      'rgba(153, 102, 255, 1)',
                      'rgba(255, 159, 64, 1)',
                      'rgba(100, 200, 50, 1)'
                  ],
                  borderWidth: 1
              }]
          },
          options: {
              scales: {
                  y: {
                      beginAtZero: true
                  }
              }
          }
      });
}

function CargarDatosGraficoBar3() {
	const ctx = document.getElementById('myChart3');
      const myChart = new Chart(ctx, {
          type: 'doughnut',
          data: {
              labels: [
              <?php
              $sql="SELECT DISTINCT tipo FROM pago INNER JOIN estancia ON pago.pagoid = estancia.pagoid GROUP BY tipo;";
              $result=pg_query($conexion,$sql);
              while ($registros = pg_fetch_array($result)){
              ?>
              '<?php echo $registros["tipo"]?>',
              <?php   
              }
              ?>
              ],
              datasets: [{
                  label: 'Numero de clientes',
                  data: 
                  <?php
                  $sql="SELECT DISTINCT tipo, COUNT (tipo) as total FROM pago INNER JOIN estancia ON pago.pagoid = estancia.pagoid GROUP BY tipo;";
                  $result = pg_query($conexion,$sql);
                  ?>
                  [<?php while ($registros = pg_fetch_array($result)) {
                  ?>
                  <?php echo $registros["total"]?>, 
                  <?php } ?>
                  ],
                  backgroundColor: [
                      'rgba(255, 99, 132, 0.2)',
                      'rgba(54, 162, 235, 0.2)',
                      'rgba(255, 206, 86, 0.2)',
                      
                      'rgba(153, 102, 255, 0.2)',
                      'rgba(255, 159, 64, 0.2)'
                  ],
                  borderColor: [
                      'rgba(255, 99, 132, 1)',
                      'rgba(54, 162, 235, 1)',
                      'rgba(255, 206, 86, 1)',
                      
                      'rgba(153, 102, 255, 1)',
                      'rgba(255, 159, 64, 1)'
                  ],
                  borderWidth: 1
              }]
          },
          options: {
              scales: {
                  y: {
                      beginAtZero: true
                  }
              }
          }
      });
}

</script>
