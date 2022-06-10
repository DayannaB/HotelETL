const { Router } = require("express");
const router = Router();
const {
  getCiudades,
  getGeneros,
  getMeses,
  filtroCiudad,
  filtroGenero,
  filtroMes,
  getData,
  graficoPrincipal,
  graficoFiltrado,
} = require("../controller/index");

//rutas for
router.get("/ciudad", getCiudades);
router.get("/genero", getGeneros);
router.get("/mes", getMeses);
router.post("/filtrociudad", filtroCiudad);
router.post("/filtrogenero", filtroGenero);
router.post("/filtromes", filtroMes);
router.get("/data", getData);
router.get("/graficoPrincipal", graficoPrincipal);
router.post("/graficoFiltrado", graficoFiltrado);

module.exports = router;
