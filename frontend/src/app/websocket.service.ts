import { Injectable } from '@angular/core';
import {webSocket, WebSocketSubject} from "rxjs/webSocket";
import {Message} from "./API/APIInterfaces";
import {environment} from "../environments/environment";
import {Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class WebsocketService {

  ws_subject: WebSocketSubject<Message>;

  constructor() {
    this.ws_subject = webSocket<Message>(environment.baseWS  + "/api/scene");
  }

  sendMessage(message) {
    this.ws_subject.next(message);
  }

}
