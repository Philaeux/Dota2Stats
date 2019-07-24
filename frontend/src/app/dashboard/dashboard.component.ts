import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  image_type: string;
  teams: string[][];
  selected_team: string;
  selected_team_2: string;
  game_id: string;

  constructor() {
  }

  ngOnInit() {
    this.image_type = 'static_teams';
    this.teams = [['39', 'Evil Geniuses']];
    this.selected_team = '39';
    this.selected_team_2 = '39';
    this.game_id = '';
  }

  image_type_changed(event) {
    console.log('toto');
  }

  selected_team_changed(event) {
    console.log('toto');
  }

  selected_team_2_changed(event) {
    console.log('toto');
  }

}
