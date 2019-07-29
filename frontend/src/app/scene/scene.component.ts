import {Component, Input, OnInit} from '@angular/core';
import {animate, state, style, transition, trigger} from "@angular/animations";
import {environment} from "../../environments/environment";
import {WebsocketService} from "../websocket.service";

@Component({
  selector: 'app-scene',
  animations: [
    trigger('showHide', [
      state('hidden', style({
        opacity: 0
      })),
      state('visible', style({
        opacity: 1
      })),
      transition('hidden => visible', [
        animate('0s')
      ]),
      transition('visible => hidden', [
        animate('0.5s')
      ])
    ])
  ],
  templateUrl: './scene.component.html',
  styleUrls: ['./scene.component.css']
})
export class SceneComponent implements OnInit {

  @Input() full_image: boolean = true;

  fade_status: string;
  live_img_src: string;
  live_img_fader_src: string;

  constructor(private webSocketService: WebsocketService) { }

  ngOnInit() {
    this.fade_status = 'hidden';
    this.webSocketService.ws_subject.subscribe(
      msg => this.update_live_image(msg.image, msg.transition),
      err => console.log(err),
      () => console.log("webSocket closed")
    );
  }

  update_live_image(image, transition) {
    if (transition == 'fade') {
      this.live_img_fader_src = this.live_img_src;
      this.fade_status = 'visible';
      setTimeout(() =>
        this.fade_status = 'hidden', 0);
    }

    this.live_img_src = environment.baseAPI + '/api/img/';
    this.live_img_src += image;
    let cache_busting = "?m=" + Math.floor((Math.random()*100000)).toString();
    this.live_img_src += cache_busting;
  }
}
