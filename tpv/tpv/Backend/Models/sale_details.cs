//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace tpv.Backend.Models
{    
    public partial class sale_details
    {
        public int id_sale_details { get; set; }
        public int id_sale { get; set; }
        public int id_product { get; set; }
        public int quantity { get; set; }
        public double price { get; set; }
    
        public virtual product product { get; set; }
        public virtual sale sale { get; set; }
    }
}
