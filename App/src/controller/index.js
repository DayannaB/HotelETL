const { Client } = require("pg");

const client = new Client({
  host: "localhost",
  user: "postgres",
  port: "5432",
  password: "123456",
  database: "Datamart2",
});

client.connect();

const getCiudades = (req, resp) => {
  client.query(
    `select distinct ciudad from cliente order by ciudad asc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const getGeneros = (req, resp) => {
  client.query(
    `select distinct genero from cliente order by genero asc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const getMeses = (req, resp) => {
  client.query(
    `select distinct mes from tiempo order by mes asc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const filtroCiudad = (req, resp) => {
  const dato = req.body;
  client.query(
    `select cliente.ciudad, cliente.genero , (tiempo.ano || '-' || tiempo.trimestre) AS Periodo , estancia.precio as valor
    from estancia inner join cliente on estancia.clienteid = cliente.clienteid
              inner join habitacion on estancia.habitacionid = habitacion.habitacionid
            inner join pago on estancia.pagoid = pago.pagoid
            inner join tiempo on estancia.tiempoid = tiempo.tiempoid
          
where cliente.ciudad = '${dato.ciudad}' order by valor desc
`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const filtroGenero = (req, resp) => {
  const dato = req.body;
  client.query(
    `select cliente.ciudad, cliente.genero , (tiempo.ano || '-' || tiempo.trimestre) AS Periodo , estancia.precio as valor
    from estancia inner join cliente on estancia.clienteid = cliente.clienteid
              inner join habitacion on estancia.habitacionid = habitacion.habitacionid
            inner join pago on estancia.pagoid = pago.pagoid
            inner join tiempo on estancia.tiempoid = tiempo.tiempoid
          
where cliente.genero = '${dato.genero}' order by valor desc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const filtroMes = (req, resp) => {
  const dato = req.body;
  client.query(
    `select cliente.ciudad, cliente.genero , (tiempo.ano || '-' || tiempo.trimestre) AS Periodo , estancia.precio as valor
    from estancia inner join cliente on estancia.clienteid = cliente.clienteid
              inner join habitacion on estancia.habitacionid = habitacion.habitacionid
            inner join pago on estancia.pagoid = pago.pagoid
            inner join tiempo on estancia.tiempoid = tiempo.tiempoid
          
where tiempo.mes = '${dato.mes}' order by valor desc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const getData = (req, resp) => {
  client.query(
    `select cliente.ciudad, cliente.genero , (tiempo.ano || '-' || tiempo.trimestre) AS Periodo , estancia.precio as valor
    from estancia inner join cliente on estancia.clienteid = cliente.clienteid
              inner join habitacion on estancia.habitacionid = habitacion.habitacionid
            inner join pago on estancia.pagoid = pago.pagoid
            inner join tiempo on estancia.tiempoid = tiempo.tiempoid
            order by valor desc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const graficoPrincipal = (req, resp) => {
  client.query(
    `select tiempo.mes , sum( estancia.precio )as valor
    from estancia inner join tiempo on estancia.tiempoid = tiempo.tiempoid
group by tiempo.mes order by tiempo.mes asc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

const graficoFiltrado = (req, resp) => {
  const dato = req.body;

  client.query(
    `select tiempo.mes , sum( estancia.precio )as valor
    from estancia 
    inner join cliente on estancia.clienteid = cliente.clienteid
      inner join tiempo on estancia.tiempoid = tiempo.tiempoid			
where ${dato.campo} = '${dato.valor}'
group by tiempo.mes order by tiempo.mes asc`,
    (err, res) => {
      if (!err) {
        resp.json(res.rows);
      } else {
        resp.json("error");
      }
      client.end;
    }
  );
};

module.exports = {
  getCiudades,
  getGeneros,
  getMeses,
  getData,
  filtroCiudad,
  filtroGenero,
  filtroMes,
  graficoPrincipal,
  graficoFiltrado,
};
