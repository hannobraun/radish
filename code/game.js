// Generated by CoffeeScript 1.3.3
(function() {

  window.module = function(moduleName, dependencyNames, moduleFactory) {
    if (window.modules == null) {
      window.modules = {};
    }
    if (window.modules[moduleName] == null) {
      return window.modules[moduleName] = {
        name: moduleName,
        dependencyNames: dependencyNames,
        factory: moduleFactory
      };
    } else {
      throw "Module " + moduleName + " is already defined.";
    }
  };

  window.load = function(moduleName, loadedModules) {
    var dependencies, dependencyName, module, _i, _len, _ref;
    if (window.modules == null) {
      throw "No modules have been defined.";
    }
    if (window.modules[moduleName] == null) {
      throw "A module called " + moduleName + " does not exist.";
    }
    if (loadedModules == null) {
      loadedModules = {};
    }
    if (loadedModules[moduleName] == null) {
      module = window.modules[moduleName];
      dependencies = {};
      _ref = module.dependencyNames;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        dependencyName = _ref[_i];
        if (modules[dependencyName] == null) {
          throw ("A module called \"" + dependencyName + "\" (defined as a ") + ("dependency in \"" + moduleName + "\") does not exist.");
        }
        dependencies[dependencyName] = load(dependencyName, loadedModules);
      }
      loadedModules[moduleName] = module.factory(dependencies);
    }
    return loadedModules[moduleName];
  };

  module("Events", [], function(m) {
    var module, publishToSubscribersOfEvent, publishToSubscribersOfTopic;
    module = {
      anyEvent: "any event",
      anyTopic: "any topic",
      createEvents: function() {
        return {
          subscribers: {},
          queue: []
        };
      },
      subscribe: function(events, eventType, topics, subscriber) {
        var subscribersOfEventByTopic, subscribersOfTopic, topic, _i, _len;
        if (!(topics instanceof Array)) {
          throw "You must specify an array of topics.";
        }
        subscribersOfEventByTopic = events.subscribers[eventType];
        if (subscribersOfEventByTopic == null) {
          subscribersOfEventByTopic = {};
        }
        for (_i = 0, _len = topics.length; _i < _len; _i++) {
          topic = topics[_i];
          subscribersOfTopic = subscribersOfEventByTopic[topic];
          if (subscribersOfTopic == null) {
            subscribersOfTopic = [];
          }
          subscribersOfTopic.push(subscriber);
          subscribersOfEventByTopic[topic] = subscribersOfTopic;
        }
        return events.subscribers[eventType] = subscribersOfEventByTopic;
      },
      publish: function(events, eventType, topic, args) {
        return events.queue.push({
          type: eventType,
          topic: topic,
          args: args
        });
      },
      execute: function(events) {
        var i, queuedEvent;
        i = 0;
        while (i < events.queue.length) {
          queuedEvent = events.queue[i];
          i += 1;
          publishToSubscribersOfEvent(events.subscribers[queuedEvent.type], queuedEvent.topic, queuedEvent.args);
          publishToSubscribersOfEvent(events.subscribers[module.anyEvent], queuedEvent.topic, queuedEvent.args);
        }
        return events.queue.length = 0;
      },
      publishAndExecute: function(events, eventType, topic, args) {
        module.publish(events, eventType, topic, args);
        return module.execute(events);
      }
    };
    publishToSubscribersOfEvent = function(subscribersOfEventByTopic, topic, args) {
      if (subscribersOfEventByTopic != null) {
        publishToSubscribersOfTopic(subscribersOfEventByTopic[topic], args);
        return publishToSubscribersOfTopic(subscribersOfEventByTopic[module.anyTopic], args);
      }
    };
    publishToSubscribersOfTopic = function(subscribersOfTopic, args) {
      var subscriber, _i, _len, _results;
      if (subscribersOfTopic != null) {
        _results = [];
        for (_i = 0, _len = subscribersOfTopic.length; _i < _len; _i++) {
          subscriber = subscribersOfTopic[_i];
          _results.push(subscriber.apply(void 0, args));
        }
        return _results;
      }
    };
    return module;
  });

  module("MainLoop", [], function(m) {
    var defaultCallNextFrame, maxFrameTimeInMs, module;
    maxFrameTimeInMs = 1000 / 30;
    defaultCallNextFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(f) {
      return window.setTimeout(function() {
        return f(Date.now());
      }, 1000 / 60);
    };
    return module = {
      execute: function(f, callNextFrame) {
        var gameTimeInS, mainLoop, previousTimeInMs;
        callNextFrame = callNextFrame || defaultCallNextFrame;
        previousTimeInMs = null;
        gameTimeInS = 0;
        mainLoop = function(currentTimeInMs) {
          var frameTimeInMs, frameTimeInS;
          frameTimeInMs = currentTimeInMs - previousTimeInMs;
          previousTimeInMs = currentTimeInMs;
          frameTimeInMs = Math.min(frameTimeInMs, maxFrameTimeInMs);
          frameTimeInS = frameTimeInMs / 1000;
          gameTimeInS += frameTimeInS;
          f(gameTimeInS, frameTimeInS);
          return callNextFrame(mainLoop);
        };
        return callNextFrame(mainLoop);
      }
    };
  });

  module("Rendering", [], function(m) {
    var module;
    return module = {
      drawFunctions: {
        "image": function(context, properties, image, imageId) {
          var alpha, orientation, position;
          if (image == null) {
            throw "Image \"" + imageId + "\" can not be found.";
          }
          position = properties.position || [0, 0];
          orientation = properties.orientation || 0;
          alpha = properties.alpha || 1;
          context.globalAlpha = alpha;
          context.translate(position[0], position[1]);
          context.rotate(orientation + image.orientationOffset);
          context.translate(image.positionOffset[0], image.positionOffset[1]);
          return context.drawImage(image.rawImage, 0, 0);
        },
        "line": function(context, properties) {
          var alpha, cap, color, end, start, width;
          start = properties.start;
          end = properties.end;
          alpha = properties.alpha || 1;
          color = properties.color || "rgb(0,0,0)";
          width = properties.width || 1;
          cap = properties.cap || "butt";
          context.globalAlpha = alpha;
          context.strokeStyle = color;
          context.lineWidth = width;
          context.lineCap = cap;
          context.beginPath();
          context.moveTo(start[0], start[1]);
          context.lineTo(end[0], end[1]);
          return context.stroke();
        },
        "rectangle": function(context, properties) {
          var color, fill, position, size;
          position = properties.position;
          size = properties.size;
          color = properties.color || "rgb(255,255,255)";
          fill = properties.fill != null ? properties.fill : true;
          if (fill) {
            context.fillStyle = color;
            return context.fillRect(position[0], position[1], size[0], size[1]);
          } else {
            context.strokeStyle = color;
            return context.strokeRect(position[0], position[1], size[0], size[1]);
          }
        }
      },
      createRenderData: function(drawFunctions, data) {
        var drawFunction, renderData, renderableType;
        renderData = {};
        for (renderableType in drawFunctions) {
          drawFunction = drawFunctions[renderableType];
          renderData[renderableType] = data[renderableType] || {};
        }
        return renderData;
      },
      createDisplay: function() {
        var canvas, context, display;
        canvas = document.getElementById("canvas");
        context = canvas.getContext("2d");
        context.translate(canvas.width / 2, canvas.height / 2);
        return display = {
          canvas: canvas,
          context: context,
          size: [canvas.width, canvas.height]
        };
      },
      createRenderable: function(type, properties, reference) {
        var renderable;
        return renderable = {
          type: type,
          properties: properties,
          reference: reference
        };
      },
      render: function(drawFunctions, display, renderData, renderables) {
        var context, drawFunction, height, renderable, resources, width, _i, _len, _results;
        context = display.context;
        width = display.size[0];
        height = display.size[1];
        context.clearRect(-width / 2, -height / 2, width, height);
        _results = [];
        for (_i = 0, _len = renderables.length; _i < _len; _i++) {
          renderable = renderables[_i];
          context.save();
          resources = renderData[renderable.type];
          drawFunction = drawFunctions[renderable.type];
          if (drawFunction == null) {
            throw "There is no draw function for renderable type \"" + renderable.type + "\".";
          }
          drawFunction(context, renderable.properties, resources[renderable.reference], renderable.reference);
          _results.push(context.restore());
        }
        return _results;
      }
    };
  });

  module("Input", ["Events"], function(m) {
    var ensureKeyNameIsValid, keyCode, keyCodesByName, keyName, keyNameArrayToKeyCodeSet, keyNamesByCode, module, mouseKeyCodesByName, mouseKeyNamesByCode, updatePointerPosition;
    keyNamesByCode = {
      8: "backspace",
      9: "tab",
      13: "enter",
      16: "shift",
      17: "ctrl",
      18: "alt",
      19: "pause",
      20: "caps lock",
      27: "escape",
      32: "space",
      33: "page up",
      34: "page down",
      35: "end",
      36: "home",
      37: "left arrow",
      38: "up arrow",
      39: "right arrow",
      40: "down arrow",
      45: "insert",
      46: "delete",
      48: "0",
      49: "1",
      50: "2",
      51: "3",
      52: "4",
      53: "5",
      54: "6",
      55: "7",
      56: "8",
      57: "9",
      65: "a",
      66: "b",
      67: "c",
      68: "d",
      69: "e",
      70: "f",
      71: "g",
      72: "h",
      73: "i",
      74: "j",
      75: "k",
      76: "l",
      77: "m",
      78: "n",
      79: "o",
      80: "p",
      81: "q",
      82: "r",
      83: "s",
      84: "t",
      85: "u",
      86: "v",
      87: "w",
      88: "x",
      89: "y",
      90: "z",
      91: "left window key",
      92: "right window key",
      93: "select key",
      96: "numpad 0",
      97: "numpad 1",
      98: "numpad 2",
      99: "numpad 3",
      100: "numpad 4",
      101: "numpad 5",
      102: "numpad 6",
      103: "numpad 7",
      104: "numpad 8",
      105: "numpad 9",
      106: "multiply",
      107: "add",
      109: "subtract",
      110: "decimal point",
      111: "divide",
      112: "f1",
      113: "f2",
      114: "f3",
      115: "f4",
      116: "f5",
      117: "f6",
      118: "f7",
      119: "f8",
      120: "f9",
      121: "f10",
      122: "f11",
      123: "f12",
      144: "num lock",
      145: "scroll lock",
      186: "semi-colon",
      187: "equal sign",
      188: "comma",
      189: "dash",
      190: "period",
      191: "forward slash",
      192: "grave accent",
      219: "open bracket",
      220: "back slash",
      221: "close braket",
      222: "single quote"
    };
    mouseKeyNamesByCode = {
      0: "left mouse button",
      1: "middle mouse button",
      2: "right mouse button"
    };
    keyCodesByName = {};
    for (keyCode in keyNamesByCode) {
      keyName = keyNamesByCode[keyCode];
      keyCodesByName[keyName] = parseInt(keyCode);
    }
    mouseKeyCodesByName = {};
    for (keyCode in mouseKeyNamesByCode) {
      keyName = mouseKeyNamesByCode[keyCode];
      mouseKeyCodesByName[keyName] = parseInt(keyCode);
    }
    ensureKeyNameIsValid = function(keyName) {
      if (!((keyCodesByName[keyName] != null) || (mouseKeyCodesByName[keyName] != null))) {
        throw "\"" + keyName + "\" is not a valid key name.";
      }
    };
    keyNameArrayToKeyCodeSet = function(keyNameArray) {
      var keyCodeSet, _i, _len;
      keyCodeSet = {};
      for (_i = 0, _len = keyNameArray.length; _i < _len; _i++) {
        keyName = keyNameArray[_i];
        keyCode = keyCodesByName[keyName];
        keyCodeSet[keyCode] = true;
      }
      return keyCodeSet;
    };
    updatePointerPosition = function(pointerPosition, display, event) {
      var element, left, top;
      element = display.canvas;
      left = 0;
      top = 0;
      while (element != null) {
        left += element.offsetLeft;
        top += element.offsetTop;
        element = element.offsetParent;
      }
      pointerPosition[0] = event.clientX - left + window.pageXOffset;
      pointerPosition[1] = event.clientY - top + window.pageYOffset;
      pointerPosition[0] -= display.size[0] / 2;
      return pointerPosition[1] -= display.size[1] / 2;
    };
    return module = {
      keyNamesByCode: keyNamesByCode,
      mouseKeyNamesByCode: mouseKeyNamesByCode,
      keyCodesByName: keyCodesByName,
      mouseKeyCodesByName: mouseKeyCodesByName,
      preventDefaultFor: function(keyNames) {
        var keyCodeSet;
        keyCodeSet = keyNameArrayToKeyCodeSet(keyNames);
        return window.addEventListener("keydown", function(keyDownEvent) {
          if (keyCodeSet[keyDownEvent.keyCode]) {
            return keyDownEvent.preventDefault();
          }
        });
      },
      createCurrentInput: function(display) {
        var currentInput;
        currentInput = {
          pressedKeys: {},
          pointerPosition: [0, 0]
        };
        window.addEventListener("keydown", function(keyDownEvent) {
          keyName = keyNamesByCode[keyDownEvent.keyCode];
          return currentInput.pressedKeys[keyName] = true;
        });
        window.addEventListener("keyup", function(keyUpEvent) {
          keyName = keyNamesByCode[keyUpEvent.keyCode];
          return currentInput.pressedKeys[keyName] = false;
        });
        window.addEventListener("mousedown", function(event) {
          keyName = mouseKeyNamesByCode[event.button];
          return currentInput.pressedKeys[keyName] = true;
        });
        window.addEventListener("mouseup", function(event) {
          keyName = mouseKeyNamesByCode[event.button];
          return currentInput.pressedKeys[keyName] = false;
        });
        display.canvas.addEventListener("mousemove", function(mouseMoveEvent) {
          return updatePointerPosition(currentInput.pointerPosition, display, mouseMoveEvent);
        });
        return currentInput;
      },
      createInputEvents: function(display) {
        var inputEvents;
        inputEvents = m.Events.createEvents();
        display.canvas.addEventListener("mousemove", function(mouseMoveEvent) {
          var pointerPosition;
          pointerPosition = [0, 0];
          updatePointerPosition(pointerPosition, display, mouseMoveEvent);
          return m.Events.publishAndExecute(inputEvents, "mousemove", [], [pointerPosition, mouseMoveEvent]);
        });
        window.addEventListener("click", function(clickEvent) {
          var pointerPosition;
          pointerPosition = [0, 0];
          updatePointerPosition(pointerPosition, display, clickEvent);
          return m.Events.publishAndExecute(inputEvents, "click", [], [pointerPosition, clickEvent]);
        });
        return inputEvents;
      },
      isKeyDown: function(currentInput, keyName) {
        ensureKeyNameIsValid(keyName);
        return currentInput.pressedKeys[keyName] === true;
      }
    };
  });

  module("Step", [], function(m) {
    var module;
    return module = {
      createStepData: function(stepTime) {
        return {
          stepTime: stepTime,
          accumulator: 0,
          totalTime: 0
        };
      },
      step: function(stepData, frameTime, f) {
        var _results;
        stepData.accumulator += frameTime;
        _results = [];
        while (stepData.accumulator >= stepData.stepTime) {
          stepData.totalTime += stepData.stepTime;
          f(stepData.totalTime, stepData.stepTime);
          _results.push(stepData.accumulator -= stepData.stepTime);
        }
        return _results;
      }
    };
  });

  module("Entities", [], function(m) {
    var module;
    return module = {
      createEntity: function(factories, components, type, args) {
        var component, componentName, entity, factory, _ref;
        factory = factories[type];
        if (factory == null) {
          throw "Entity type \"" + type + "\" is not known.";
        }
        entity = factory(args);
        _ref = entity.components;
        for (componentName in _ref) {
          component = _ref[componentName];
          if (components[componentName] == null) {
            components[componentName] = {};
          }
          components[componentName][entity.id] = component;
        }
        return entity.id;
      },
      destroyEntity: function(components, entityId) {
        var componentMap, componentType, _results;
        _results = [];
        for (componentType in components) {
          componentMap = components[componentType];
          _results.push(delete componentMap[entityId]);
        }
        return _results;
      }
    };
  });

  module("Images", [], function(m) {
    var module;
    return module = {
      loadImages: function(imagePaths, onLoad) {
        var image, imagePath, images, numberOfImagesToLoad, _i, _len, _results;
        images = {};
        numberOfImagesToLoad = imagePaths.length;
        _results = [];
        for (_i = 0, _len = imagePaths.length; _i < _len; _i++) {
          imagePath = imagePaths[_i];
          image = new Image;
          images[imagePath] = image;
          image.onload = function() {
            numberOfImagesToLoad -= 1;
            if (numberOfImagesToLoad === 0) {
              return onLoad(images);
            }
          };
          _results.push(image.src = imagePath);
        }
        return _results;
      },
      process: function(rawImages) {
        var imageId, imagePath, images, rawImage;
        images = {};
        for (imagePath in rawImages) {
          rawImage = rawImages[imagePath];
          imageId = imagePath.substring(imagePath.indexOf("/") + 1);
          images[imageId] = {
            rawImage: rawImage,
            positionOffset: [-rawImage.width / 2, -rawImage.height / 2],
            orientationOffset: 0
          };
        }
        return images;
      }
    };
  });

  module("Graphics", ["Rendering", "Vec2"], function(m) {
    var module;
    return module = {
      createRenderState: function() {
        var renderState;
        return renderState = {
          renderables: []
        };
      },
      updateRenderState: function(renderState, gameState) {
        var entityId, imageId, position, renderable, _ref, _results;
        renderState.renderables.length = 0;
        _ref = gameState.components.positions;
        _results = [];
        for (entityId in _ref) {
          position = _ref[entityId];
          imageId = gameState.components.imageIds[entityId];
          renderable = m.Rendering.createRenderable("image", {
            position: position
          }, imageId);
          _results.push(renderState.renderables.push(renderable));
        }
        return _results;
      }
    };
  });

  module("Main", ["Images", "Rendering", "Input", "MainLoop", "Step", "Logic", "Graphics"], function(m) {
    return m.Images.loadImages(["images/star.png"], function(rawImages) {
      var currentInput, display, gameState, images, renderData, renderState, stepData;
      images = m.Images.process(rawImages);
      renderData = m.Rendering.createRenderData(m.Rendering.drawFunctions, {
        "image": images
      });
      m.Input.preventDefaultFor(["up arrow", "down arrow", "left arrow", "right arrow", "space"]);
      stepData = m.Step.createStepData(1 / 60);
      display = m.Rendering.createDisplay();
      currentInput = m.Input.createCurrentInput(display);
      gameState = m.Logic.createGameState();
      renderState = m.Graphics.createRenderState();
      m.Logic.initGameState(gameState);
      return m.MainLoop.execute(function(gameTimeInS, frameTimeInS) {
        m.Step.step(stepData, frameTimeInS, function(totalStepTimeInS, stepTimeInS) {
          return m.Logic.updateGameState(gameState, currentInput, totalStepTimeInS, stepTimeInS);
        });
        m.Graphics.updateRenderState(renderState, gameState);
        return m.Rendering.render(m.Rendering.drawFunctions, display, renderData, renderState.renderables);
      });
    });
  });

  module("Logic", ["Input", "Entities", "Vec2"], function(m) {
    var createEntity, destroyEntity, entityFactories, module, nextEntityId;
    nextEntityId = 0;
    entityFactories = {
      "myEntity": function(args) {
        var entity, id, movement;
        movement = {
          center: args.center,
          radius: args.radius,
          speed: args.speed
        };
        id = nextEntityId;
        nextEntityId += 1;
        return entity = {
          id: id,
          components: {
            "positions": [0, 0],
            "movements": movement,
            "imageIds": "star.png"
          }
        };
      }
    };
    createEntity = null;
    destroyEntity = null;
    return module = {
      createGameState: function() {
        var gameState;
        return gameState = {
          components: {}
        };
      },
      initGameState: function(gameState) {
        createEntity = function(type, args) {
          return m.Entities.createEntity(entityFactories, gameState.components, type, args);
        };
        destroyEntity = function(entityId) {
          return m.Entities.destroyEntity(gameState.components, entityId);
        };
        createEntity("myEntity", {
          center: [0, 0],
          radius: 50,
          speed: 2
        });
        return createEntity("myEntity", {
          center: [0, 0],
          radius: 100,
          speed: -1
        });
      },
      updateGameState: function(gameState, currentInput, gameTimeInS, frameTimeInS) {
        var angle, entityId, movement, position, _ref, _results;
        _ref = gameState.components.positions;
        _results = [];
        for (entityId in _ref) {
          position = _ref[entityId];
          movement = gameState.components.movements[entityId];
          angle = gameTimeInS * movement.speed;
          position[0] = movement.radius * Math.cos(angle);
          position[1] = movement.radius * Math.sin(angle);
          _results.push(m.Vec2.add(position, currentInput.pointerPosition));
        }
        return _results;
      }
    };
  });

  module("Mat3x3", [], function(m) {
    var module;
    return module = {
      multiply: function(m1, m2) {
        var m00, m01, m02, m10, m11, m12, m20, m21, m22;
        m00 = m1[0][0];
        m01 = m1[0][1];
        m02 = m1[0][2];
        m10 = m1[1][0];
        m11 = m1[1][1];
        m12 = m1[1][2];
        m20 = m1[2][0];
        m21 = m1[2][1];
        m22 = m1[2][2];
        m1[0][0] = m00 * m2[0][0] + m01 * m2[1][0] + m02 * m2[2][0];
        m1[0][1] = m00 * m2[0][1] + m01 * m2[1][1] + m02 * m2[2][1];
        m1[0][2] = m00 * m2[0][2] + m01 * m2[1][2] + m02 * m2[2][2];
        m1[1][0] = m10 * m2[0][0] + m11 * m2[1][0] + m12 * m2[2][0];
        m1[1][1] = m10 * m2[0][1] + m11 * m2[1][1] + m12 * m2[2][1];
        m1[1][2] = m10 * m2[0][2] + m11 * m2[1][2] + m12 * m2[2][2];
        m1[2][0] = m20 * m2[0][0] + m21 * m2[1][0] + m22 * m2[2][0];
        m1[2][1] = m20 * m2[0][1] + m21 * m2[1][1] + m22 * m2[2][1];
        return m1[2][2] = m20 * m2[0][2] + m21 * m2[1][2] + m22 * m2[2][2];
      }
    };
  });

  module("Transform2d", [], function(m) {
    var module;
    return module = {
      identityMatrix: function() {
        return [[1, 0, 0], [0, 1, 0], [0, 0, 1]];
      },
      translationMatrix: function(v) {
        return [[1, 0, v[0]], [0, 1, v[1]], [0, 0, 1]];
      },
      rotationMatrix: function(angle) {
        return [[Math.cos(angle), -Math.sin(angle), 0], [Math.sin(angle), Math.cos(angle), 0], [0, 0, 1]];
      },
      scalingMatrix: function(factor) {
        return [[factor, 0, 0], [0, factor, 0], [0, 0, 1]];
      }
    };
  });

  module("Vec2", [], function(m) {
    var module;
    return module = {
      copy: function(v) {
        return [v[0], v[1]];
      },
      overwrite: function(v1, v2) {
        v1[0] = v2[0];
        return v1[1] = v2[1];
      },
      equals: function(v1, v2) {
        return v1[0] === v2[0] && v1[1] === v2[1];
      },
      scale: function(v, s) {
        v[0] *= s;
        return v[1] *= s;
      },
      add: function(v1, v2) {
        v1[0] += v2[0];
        return v1[1] += v2[1];
      },
      subtract: function(v1, v2) {
        v1[0] -= v2[0];
        return v1[1] -= v2[1];
      },
      dot: function(v1, v2) {
        return v1[0] * v2[0] + v1[1] * v2[1];
      },
      perpDot: function(v1, v2) {
        return -v1[1] * v2[0] + v1[0] * v2[1];
      },
      length: function(v) {
        return Math.sqrt(v[0] * v[0] + v[1] * v[1]);
      },
      squaredLength: function(v) {
        return v[0] * v[0] + v[1] * v[1];
      },
      normalize: function(v) {
        var length;
        length = module.length(v);
        v[0] /= length;
        return v[1] /= length;
      },
      perp: function(v) {
        var x, y;
        x = v[0];
        y = v[1];
        v[0] = -y;
        return v[1] = x;
      },
      applyTransform: function(v, t) {
        var x, y;
        x = v[0], y = v[1];
        v[0] = x * t[0][0] + y * t[0][1] + 1 * t[0][2];
        return v[1] = x * t[1][0] + y * t[1][1] + 1 * t[1][2];
      }
    };
  });

}).call(this);