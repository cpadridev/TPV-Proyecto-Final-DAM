using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace tpv.Backend.Services.Base
{
    /*
     * Interfaz que nos muestra las principales operaciones a realizar con los objetos 
     * de la base de datos
     */
    interface IGenericService<T> where T : class
    {
        /*
         * Obtiene todos los objetos de una determinada entidad
         */
        IEnumerable<T> GetAll();
        /*
         * Busca elementos según la expresión o predicado pasado como parámetro
         */
        IEnumerable<T> FindBy(Expression<Func<T, bool>> predicate);
        /*
         * Busca un objeto por su identificador
         */
        T FindByID(int id);
        /*
         * Inserta un objeto nuevo en la base de datos
         * Luego se debe de realizar un commit para que se hagan persistentes los cambios
         */
        T Add(T entity);
        /*
         * Borra un objeto de la base de datos en función de su id
         * Luego se debe de realizar un commit para que se hagan persistentes los cambios
         */
        T Delete(T entity);
        /*
         * Edita un objeto de la base de datos
         * Luego se debe de realizar un commit para que se hagan persistentes los cambios
         */
        void Edit(T entity);
        /*
         * Realiza un commit para que los cambios se hagan persistentes
         */
        void Save();
    }
}
