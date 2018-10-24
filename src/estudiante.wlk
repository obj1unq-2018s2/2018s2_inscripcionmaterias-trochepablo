import materiaAprobadaAlumno.*
import carrera.*

class Estudiante {
	const materiasAprobadas = []
	const property carreras = []
	const property materias = [] // la logica de llenar esta lista en cuando se agrega o quitar al estudiante de la materia
	const property listaEspera = []
	
	method materiasAprobadas() = self.materiasAprobadas()
	method agregarMateriaAprobada(materia) {
		if(not self.materiaEstaAprobada(materia)){
			materiasAprobadas.add(new MateriaAprobadaAlumno(materia = materia, calificacion =  7))
		}
	}
	
	method puedeCursarMateria(materia) = 
		carreras.any{ x => x.materiaCorrespondeACarrera(materia) }
		&&
		not self.materiasAprobadas().any{ x => self.materiaEstaAprobada(x) }
		&&
		materia.preRrequisitos(self)
		
		
	method materiaEstaAprobada(materia) = materiasAprobadas.any{ x => x.materia() == materia  && x.calificacion() > 7 }
	
	method creditos() = materiasAprobadas.sum{ x => x.creditosQueOtorga() } 
	
	method alumnosCursaCarrera(carrera) = carreras.contains(carrera)
	
}
