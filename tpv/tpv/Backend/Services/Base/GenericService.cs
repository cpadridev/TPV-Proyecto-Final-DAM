using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;

namespace tpv.Backend.Services.Base
{
    /*
     * Clase que implementa la interfaz de acceso a datos
     */
    public class GenericService<T> : IGenericService<T>
        where T : class
    {
        // Objeto que accede a la capa de acceso a datos creada por Entity Framework
        protected DbContext _entities;
        // Objeto que nos permite acceder a las clases asociadas con las tablas de la base de datos
        protected readonly IDbSet<T> _dbset;

        /*
         * Constructor
         * Paramatro: objeto que nos permite acceder a las clases asociadas a la base de datos
         */
        public GenericService(DbContext context)
        {
            _entities = context;
            _dbset = context.Set<T>();
        }

        /*
         * Añade la entidad a la base de datos
         * Necesita de un commit para hacer la transacción persistente
         * Parámetro: entidad de tipo genérico
         */
        public T Add(T entity)
        {
            return _dbset.Add(entity);
        }
        /*
         * Borra la entidad a la base de datos
         * Necesita de un commit para hacer la transacción persistente
         * Parámetro: entidad de tipo genérico
         */
        public T Delete(T entity)
        {
            return _dbset.Remove(entity);
        }
        /*
         * Devuelve una lista con todos los objetos de una tabla de la base de datos
         */
        public IEnumerable<T> GetAll()
        {
            return _dbset.AsEnumerable<T>();
        }
        /*
         * Realiza un commit de la cache a la base de datos
         */
        public void Save()
        {
            _entities.SaveChanges();
        }
        /*
         * Devuelve un objeto identificado por su id
         * Parametro: identificador
         */
        public T FindByID(int id)
        {
            return _dbset.Find(id);
        }
        /*
         * Añade la entidad a la base de datos
         * Necesita de un commit para hacer la transacción persistente
         * Parámetro: entidad de tipo genérico
         */
        public void Edit(T entity)
        {
            _entities.Entry(entity).State = EntityState.Modified;
        }

        public IEnumerable<T> FindBy(Expression<Func<T, bool>> predicate)
        {
            IEnumerable<T> query = _dbset.Where(predicate).AsEnumerable();
            return query;
        }
    }
}
