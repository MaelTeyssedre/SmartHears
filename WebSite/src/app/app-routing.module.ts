import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ContactComponent } from './pages/contact/contact.component';
import { HomeComponent } from './pages/home/home.component';
import { EditPackComponent } from './pages/library/edit-pack/edit-pack.component';
import { LibraryComponent } from './pages/library/library.component';
import { ProfilComponent } from './pages/profil/profil.component';
import { SettingsComponent } from './pages/settings/settings.component';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },
  { path: 'library', component: LibraryComponent },
  { path: 'profil', component: ProfilComponent },
  { path: 'settings', component: SettingsComponent },
  { path: 'contact', component: ContactComponent },
  { path: 'library/edit', component: EditPackComponent },
  { path: 'library/create', component: EditPackComponent },
  { path: '**', redirectTo: 'home' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
