import materia.*

class Carrera {
	var property nombre;
	const property materias = []
	method materiaCorrespondeACarrera(materia) = materias.any{ x => x == materia }
}
