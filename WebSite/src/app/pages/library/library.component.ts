import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { SoundPacks, Status } from 'src/app/models/ISoundPack';

@Component({
  selector: 'app-library',
  templateUrl: './library.component.html',
  styleUrls: ['./library.component.scss']
})
export class LibraryComponent implements OnInit {

  public soundPacks: SoundPacks[] = [];

  public showedSoundPacks: SoundPacks[] = [];

  public searchedPack = new FormControl('');

  constructor() { }

  ngOnInit(): void {
    for (let i = 1; i < 101; i++) {
      this.soundPacks.push({
        id: i,
        color: '#' + Math.floor(Math.random() * 16777215).toString(16),
        color2: '#' + Math.floor(Math.random() * 16777215).toString(16),
        title: 'Sound Pack ' + i,
        description: 'This is a description of the sound pack',
        image: 'https://picsum.photos/200/300?random=' + i,
        status: Status.public,
        voices: [
          {
            id: 1,
            name: 'John Doe',
            status: 'active',
            job: 'Sound Designer'
          },
        ]
      })
    }
    this.showedSoundPacks = this.soundPacks;
  }

  public onChangeEvent(event: any): void {
    this.showedSoundPacks = this.soundPacks.filter(pack => pack.title!.toLowerCase().includes(event.target.value.toLowerCase()));
  }

  public cacheEditedSoundPack(soundPack: SoundPacks): void {
    localStorage.setItem('soundPacks', JSON.stringify(soundPack));
  }
}
