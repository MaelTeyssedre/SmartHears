import { Component, OnInit } from '@angular/core';
import * as AOS from 'aos';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit {
  public text: string = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,\
    molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum\
    numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium\
    optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis\
    obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam\
    nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit,\
    tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit,"

  constructor() {}

  ngOnInit(): void {
    AOS.init({
      duration: 1000,
      easing: 'ease-in-out-back',
    })
  }
}
