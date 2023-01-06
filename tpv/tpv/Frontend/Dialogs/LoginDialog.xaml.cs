using MahApps.Metro.Controls;
using MahApps.Metro.Controls.Dialogs;
using System.Windows;
using tpv.Backend.Models;
using tpv.Backend.Services;

namespace tpv.Frontend.Dialogs
{
    /// <summary>
    /// Lógica de interacción para LoginDialog.xaml
    /// </summary>
    public partial class LoginDialog : MetroWindow
    {
        private tpvEntities tpvEntities;
        private UserService userService;

        public LoginDialog()
        {
            InitializeComponent();
            tpvEntities = new tpvEntities();
            userService = new UserService(tpvEntities);
            txbUsername.Focus();
        }

        private async void btnLogin_Click(object sender, RoutedEventArgs e)
        {
            string user = txbUsername.Text;
            string password = pwdPassword.Password;

            if (string.IsNullOrEmpty(user))
            {
                txbUsername.Focus();
                await this.ShowMessageAsync("LOGIN", "El usuario está vacío");
            }
            else if (string.IsNullOrEmpty(password))
            {
                pwdPassword.Focus();
                await this.ShowMessageAsync("LOGIN", "La contraseña está vacío");
            }
            else if (userService.Login(user, password))
            {
                MainWindow dialog = new MainWindow(tpvEntities, userService.userLoggedIn);
                dialog.Show();
                this.Close();
            }
            else
            {
                await this.ShowMessageAsync("LOGIN", "El usuario y/o la contraseña no coinciden");
            }
        }
    }
}
