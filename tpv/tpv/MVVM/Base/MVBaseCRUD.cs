using NLog;
using System.Data.Entity.Infrastructure;
using tpv.Backend.Services.Base;

namespace tpv.MVVM.Base
{
    public class MVBaseCRUD<T> : MVBase
        where T : class
    {
        public GenericService<T> service { get; set; }
        private static Logger log = LogManager.GetCurrentClassLogger();

        /// <summary>
        /// Realiza una inserción en la base de datos y captura la excepción
        /// </summary>
        /// <param name="entity">Objeto a guardar</param>
        /// <returns></returns>
        public bool Add(T entity)
        {
            try
            {
                service.Add(entity);
                service.Save();
            }
            catch (DbUpdateException dbex)
            {
                // Guardamos en el Log el error
                log.Error("\n" + "Insertando un nuevo objeto ..." + entity.GetType() + "\n" + dbex.Message + "\n" + dbex.StackTrace);
                return false;
            }

            return true;
        }

        /// <summary>
        /// Realiza una actualización de una tupla de la base de datos
        /// </summary>
        /// <param name="entity">Objeto que se actualiza</param>
        /// <returns></returns>
        public bool Update(T entity)
        {
            try
            {
                service.Edit(entity);
                service.Save();
            }
            catch (DbUpdateException dbex)
            {
                // Guardamos en el Log el error
                log.Error("\n" + "Insertando un nuevo objeto ..." + entity.GetType() + "\n" + dbex.Message + "\n" + dbex.StackTrace);
                return false;
            }

            return true;
        }

        /// <summary>
        /// Borra una fila de la tabla correspondiente
        /// </summary>
        /// <param name="entity">Objeto que se borra</param>
        /// <returns></returns>
        public bool Delete(T entity)
        {
            try
            {
                service.Delete(entity);
                service.Save();
            }
            catch (DbUpdateException dbex)
            {
                // Guardamos en el Log el error
                log.Error("\n" + "Insertando un nuevo objeto ..." + entity.GetType() + "\n" + dbex.Message + "\n" + dbex.StackTrace);
                return false;
            }

            return true;
        }
    }
}
