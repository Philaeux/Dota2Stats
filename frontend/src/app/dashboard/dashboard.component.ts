import { Component, OnInit } from '@angular/core';
import { HttpClient } from "@angular/common/http";

import { environment } from "../../environments/environment";
import { teams } from "../data"
import { APIResult, Message } from "../API/APIInterfaces";
import {WebsocketService} from "../websocket.service";

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

  preview_img_src: string;

  constructor(
    private http: HttpClient,
    private webSocketService: WebsocketService
  ) {}

  ngOnInit() {
    this.image_type = 'static_teams';
    this.teams = teams;
    this.selected_team = '39';
    this.selected_team_2 = '39';
    this.game_id = '';

    this.rebuild_preview();
  }

  build_image_name() {
    let image_name = "";

    switch (this.image_type) {
      case 'static_teams':
        image_name += this.image_type + '-' + this.selected_team;
        break;
      case 'group_stage':
      case 'tournament_globals':
        image_name += this.image_type;
        break;
      case 'post_game':
        image_name += this.image_type + '-' + this.game_id;
        break;
      case 'team_face_off':
        image_name += this.image_type + '-' + this.selected_team + '-' + this.selected_team_2;
        break;
    }
    image_name += ".png";

    return image_name
  }

  rebuild_preview() {
    this.preview_img_src = environment.baseAPI + '/api/img/';
    this.preview_img_src += this.build_image_name();
    let cache_busting = "?m=" + Math.floor((Math.random()*100000)).toString();
    this.preview_img_src += cache_busting;
  }

  generate() {
    let payload = { "image_type": this.image_type };
    switch (this.image_type) {
      case "static_teams":
        payload["team_id"] = this.selected_team;
        break;
      case "post_game":
        payload["game_id"] = this.game_id;
        break;
      case "team_face_off":
        payload["team_id_1"] = this.selected_team;
        payload["team_id_2"] = this.selected_team_2;
    }
    this.http.post<APIResult>(environment.baseAPI + "/api/generate", payload).subscribe(json => {
      if (json.success) {
        this.rebuild_preview();
      }
    });
  }

  fade_in() {
    this.webSocketService.sendMessage({
      "image": this.build_image_name(),
      "transition": "fade"
    });
  };

  cut_in() {
    this.webSocketService.sendMessage({
      "image": this.build_image_name(),
      "transition": "cut"
    });
  }
}
