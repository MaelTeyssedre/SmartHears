import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { SoundPacks, Status } from 'src/app/models/ISoundPack';
import { StatusArray } from 'src/app/models/ISoundPack';
import { MatTableDataSource } from '@angular/material/table';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-edit-pack',
  templateUrl: './edit-pack.component.html',
  styleUrls: ['./edit-pack.component.scss']
})
export class EditPackComponent implements OnInit {

  public soundPack: SoundPacks | undefined;

  public statusArray: string[] = StatusArray

  public displayedColumns: string[] = ['name', 'status', 'job', 'actions'];

  public dataSource: any;

  public edit: boolean =  false;

  constructor(
    private route: ActivatedRoute,
    private snackBar: MatSnackBar
  ) { }

  ngOnInit(): void {
    if (localStorage.getItem('soundPacks') && JSON.parse(localStorage.getItem('soundPacks') || '') && !this.soundPack) {
      this.soundPack = JSON.parse(localStorage.getItem('soundPacks') || '');
      this.dataSource = new MatTableDataSource(this.soundPack!.voices)
    } else if (this.soundPack === undefined){
      // get id from query param and get sound pack from api
      this.route.queryParams.subscribe(params => {
        if (params['id']) {
          this.soundPack = {
            id: params['id'],
            color: '#' + Math.floor(Math.random() * 16777215).toString(16),
            color2: '#' + Math.floor(Math.random() * 16777215).toString(16),
            title: 'Sound Pack ' + params['id'],
            description: 'This is a description of the sound pack',
            image: 'https://picsum.photos/200/300?random=' + params['id'],
            status: Status.public,
            voices: [
              {
                id: 1,
                name: 'John Doe',
                status: 'active',
                job: 'Sound Designer'
              },
              {
                id: 2,
                name: 'Jane Doe',
                status: 'active',
                job: 'Sound Designer'
              },
            ]
          }
          this.dataSource = new MatTableDataSource(this.soundPack!.voices);
          this.edit = true;
        }
      });
    }
  }

  public goBack(): void {
    window.history.back();
  }

  public applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  public addVoice(): void {
    this.soundPack!.voices.push({
      id: this.soundPack!.voices.length + 1,
      name: 'random name' + this.soundPack!.voices.length,
      status: 'not active',
      job: 'random job' + this.soundPack!.voices.length
    })
    this.dataSource = new MatTableDataSource(this.soundPack!.voices);
  }

  public deleteVoice(element: any): void {
    this.soundPack!.voices.splice(this.soundPack!.voices.indexOf(element), 1);
    this.dataSource = new MatTableDataSource(this.soundPack!.voices);
  }

  public save(): void {
    this.snackBar.open('Le pack de voix à bien été enregistré', '', {
      duration: 2000,
      verticalPosition: 'top',
      horizontalPosition: 'center'
    });
  }
}
