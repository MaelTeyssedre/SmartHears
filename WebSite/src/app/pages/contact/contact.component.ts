import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.scss']
})
export class ContactComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

  public goToRickRollYoutube(): void {
    window.open('https://www.youtube.com/watch?v=dQw4w9WgXcQ', '_blank');
  }
}
