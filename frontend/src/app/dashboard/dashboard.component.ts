import { Component, OnInit } from '@angular/core';
import { HttpClient } from "@angular/common/http";

import { environment } from "../../environments/environment";
import { teams } from "../data"
import { APIResult, APIGroupStageResult } from "../API/APIInterfaces";
import {WebsocketService} from "../websocket.service";

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  group_data_columns: string[] = ['id', "name", 'group_number', 'position', "wins", "loses", "color", "actions"];
  group_data_source: object[] = [];

  image_type: string;
  teams: string[][];
  selected_team: string;
  selected_team_2: string;
  group_stage_team: string;
  game_id: string;
  slot: string;

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
    this.group_stage_team = '39';
    this.game_id = '4874722743';
    this.slot = "0";

    this.rebuild_preview();
    this.refresh_group_stage();
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
      case 'mvp':
        image_name += this.image_type + '-' + this.game_id;
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
        break;
      case "mvp":
        payload["game_id"] = this.game_id;
        payload["slot"] = this.slot;
        break;
    }
    this.http.post<APIResult>(environment.baseAPI + "/api/generate", payload).subscribe(json => {
      if (json.success) {
        this.rebuild_preview();
      } else {
        console.log(json);
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

  insert_team() {
    let payload = { "id": (<number>(<unknown> this.group_stage_team )) };
    this.http.post<APIResult>(environment.baseAPI + "/api/group_stage/add", payload).subscribe(json => {
      if (json.success) {
        this.refresh_group_stage();
      }
    });
  }

  refresh_group_stage() {
    this.http.get<APIResult>(environment.baseAPI + "/api/group_stage/list").subscribe(json => {
      if (json.success) {
        let result = (<APIGroupStageResult>json.payload);
        this.group_data_source = result.groups;
      }
    });
  }

  delete_group_team(id) {
    let payload = { "id": id };
    this.http.post<APIResult>(environment.baseAPI + "/api/group_stage/delete", payload).subscribe(json => {
      if (json.success) {
        this.refresh_group_stage();
      }
    });
  }

  update_group_team(element) {
    let payload = { "id": element.id, "group_number": element.group_number, "position": element.position,
                    "wins": element.wins, "loses": element.loses, "color": element.color };
    this.http.post<APIResult>(environment.baseAPI + "/api/group_stage/update", payload).subscribe(json => {
      if (json.success) {
        this.refresh_group_stage();
      }
    });
  }
}
