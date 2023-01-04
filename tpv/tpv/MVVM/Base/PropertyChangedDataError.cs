using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;

namespace tpv.MVVM.Base
{
    public class PropertyChangedDataError : INotifyPropertyChanged, IDataErrorInfo
    {
        // Implementa la interfaz INotifyPropertyChanged
        #region Property Changed

        public event PropertyChangedEventHandler PropertyChanged;

        protected void NotifyPropertyChanged([CallerMemberName] string name = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
        }

        #endregion
        // Implementa la interfaz IDataErrorInfo
        #region DataErrorInfo

        // check for general model error
        public string Error { get { return null; } }

        // check for property errors
        public string this[string columnName]
        {
            get
            {
                var validationResults = new List<ValidationResult>();

                if (Validator.TryValidateProperty(GetType().GetProperty(columnName).GetValue(this), new ValidationContext(this) { MemberName = columnName }, validationResults))
                {
                    return null;
                }

                return validationResults.First().ErrorMessage;
            }
        }
        #endregion
    }
}
