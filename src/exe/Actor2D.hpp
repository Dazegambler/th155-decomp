#pragma once
#include <list>
#ifndef ACTOR2D_H
#define ACTOR2D_H

#include "D3D.h"
#include "bt.h"
#include "kite_api.h"
#include "sqrat.h"
#include "squirrel/include/squirrel.h"
#include <cstdint>
#include <memory>
#include <vector>

namespace Manbow {
// size: 0x2C
struct World2D {
  char __unk0[0x20];              // 0x0
  btCollisionWorld *bullet_world; // 0x20
  char __unk24[8];                // 0x24
                                  // 0x2C
};

static_assert(sizeof(World2D) == 0x2C);

struct ActorCollisionData {
  char __unk0[0xC];       // 0x0
  btGhostObject *obj_ptr; // 0xC
  btGhostObject obj;      // 0x10
};

// size: 0x50
struct AnimationData {
  char __unk0[0xC];          // 0x0
  int32_t frame_total;       // 0xc
  uint32_t flag_state;       // 0x10
  uint32_t flag_attack;      // 0x14
  char __unk18[0x50 - 0x18]; // 0x18
                             // 0x50
};

static_assert(sizeof(AnimationData) == 0x50);

struct Sprite;

struct Actor2DTakeData {
  void *__unk0;                                 // 0x0
  Actor2DTakeData *next;                        // 0x4
  Actor2DTakeData *previous;                    // 0x8
  AnimationData *frame_data;                    // 0xc
  int32_t frame_total;                          // 0x10
  std::vector<std::shared_ptr<Sprite>> sprites; // 0x14
};

struct AnimationNode {
  AnimationNode *__node0; // 0x0
  AnimationNode *start;   // 0x4
  AnimationNode *__node8; // 0x8
  char __bytec;           // 0xc
  bool __boold;           // 0xd
  char __pad[2];          // 0xe
  int32_t motionId;       // 0x10
  Actor2DTakeData *take;  // 0x14
};

struct AnimationSet2D {
  void *__unk4;         // 0x4
  AnimationNode *nodes; // 0x8
  uint32_t __intc;      // 0xC
  void *__unk10;        // 0x10
  uint32_t __int14;     // 0x14

  virtual AnimationNode *CurrentMotion();

  virtual inline AnimationNode *GetMotion(int32_t motion) {
    AnimationNode *new_anim = this->nodes;
    AnimationNode *search_anim = this->nodes->start;
    while (!search_anim->__boold) {
      if (search_anim->motionId < motion) {
        search_anim = search_anim->__node8;
      } else {
        new_anim = search_anim;
        search_anim = search_anim->__node0;
      }
    }
    if (new_anim == this->nodes || motion < new_anim->motionId) {
      new_anim = this->nodes;
    }
    return new_anim;
  }
};

// size: 0x120
struct AnimationControllerBase {
  char __unk4[0x18];                                           // 0x4
  uint32_t motion;                                             // 0x1c
  int32_t key_take;                                            // 0x20
  uint32_t keyframe;                                           // 0x24
  float red;                                                   // 0x28
  float green;                                                 // 0x2C
  float blue;                                                  // 0x30
  float alpha;                                                 // 0x34
  D3DMATRIX __matrix_38;                                       // 0x38
  std::vector<std::shared_ptr<ActorCollisionData>> col_boxes;  // 0x78
  std::vector<std::shared_ptr<ActorCollisionData>> hit_boxes;  // 0x84
  std::vector<std::shared_ptr<ActorCollisionData>> hurt_boxes; // 0x90
  char __unk9C[0x84];                                          // 0x9C
                                                               // 0x120
  virtual void __method0();
  virtual void __method4();
  virtual void __method8();
  virtual void __methodC();
  virtual void __method10();
  virtual void __method14();
  virtual bool SetMotion(uint32_t motion, int32_t take);
  virtual bool SetTake(int32_t take);
  virtual bool PlayTake(int32_t keyframe);
  virtual void SetBoxes();
  virtual void __method28();
  virtual void __method2C();
  virtual void __method30();
  virtual void __method34();
  virtual void __method38();
  virtual void __method3C();
  virtual void __method40();
  virtual void __method44();
  virtual void __method48();
  virtual void __method4C();
  virtual void __method50();
  virtual void __method54();
  virtual void __method58();
  virtual void __method5C();
  virtual void __method60();
  virtual void __method64();
  virtual void __method68();
  virtual void __method6C();
  virtual void __method70();
  virtual void __method74();
  virtual void __method78();
  virtual void __method7C();
  virtual void __method80();
  virtual void __method84();
  virtual void __method88();
  virtual void __method8C();
  virtual void __method90();
  virtual void __method94();
  virtual void __method98();
  virtual void __method9C();
  virtual void __methodA0();
  virtual void __methodA4();
  virtual void __methodA8();
  virtual void __methodAC();
  virtual void __methodB0();
};

// size: 0x230
struct AnimationController2D : AnimationControllerBase {
  void *tf4_imaterial_vftable;                  // 0x120
  AnimationSet2D *anim_set;                     // 0x124
  void *__unk128;                               // 0x128
  Actor2DTakeData *take;                        // 0x12C
  AnimationData *animation_data;                // 0x130
  int32_t frame;                                // 0x134
  int32_t frame_again;                          // 0x138
  uint16_t speed;                               // 0x13C
  char __unk13C[0x224 - 0x140];                 // 0x140
  std::vector<std::shared_ptr<Sprite>> sprites; // 0x224
                                                // 0x230

  bool SetMotion(uint32_t motion, int32_t take) {
    AnimationNode *current_anim = this->anim_set->CurrentMotion();
    AnimationNode *new_anim = this->anim_set->GetMotion(motion);
    if (new_anim == current_anim) {
      return false;
    }

    this->motion = motion;
    this->take = new_anim->take;
    return this->SetTake(take);
  }

  bool SetTake(int32_t take) {
    while (this->take->previous) {
      this->take = this->take->previous;
    }
    this->key_take = 0;
    for (int32_t i = 0; i < take; ++i) {
      this->take = this->take->next;
      this->key_take = i;
    }
    this->sprites.clear();
    this->sprites.resize(this->take->sprites.size());
    take = 0;
    while (take < this->sprites.size()) {
      this->sprites[take] = this->take->sprites[take];
      // then deletes that element on the take vector with function i have yet
      // to reverse but it's on Rx7E560
    }
    this->PlayTake(0);
    return true;
  }

  bool PlayTake(int32_t keyframe) {
    Actor2DTakeData *take = this->take;
    if (!take) {
      return false;
    }
    this->keyframe = keyframe;
    this->animation_data = &take->frame_data[keyframe];
    int32_t frame = 0;
    if (keyframe) {
      frame = take->frame_data[keyframe - 1].frame_total;
    }
    this->frame = frame;
    this->frame_again = frame;
    this->SetBoxes();
    return true;
  }

  void SetBoxes();
};

static_assert(sizeof(AnimationController2D) == 0x230);

// size: 0x268
struct AnimationController3D : AnimationControllerBase {
  char __unk120[0x138]; // 0x120
  float __unk258;       // 0x258
  float __unk25C;       // 0x25C
  float __unk260;       // 0x260
  float __unk264;       // 0x264
                        // 0x268
};

static_assert(sizeof(AnimationController3D) == 0x268);

// size: 0x280
struct AnimationControllerDynamic : AnimationController2D {
  char __unk230[0x50]; // 0x230
                       // 0x280
};

// size: 0x240
struct AnimationControllerStencil : AnimationController2D {
  char __unk230[0x10]; // 0x230
                       // 0x240
};

// size: 0x300
struct AnimationControllerTrail : AnimationController2D {
  char __unk230[0xD0]; // 0x230
                       // 0x300
};

struct Camera2D {
  char dont_care0[0x1C];          // 0x0
  D3DMATRIX view_proj_matrix;     // 0x1C
  D3DMATRIX view_matrix;          // 0x5C
  D3DMATRIX proj_matrix;          // 0x9C
  char dont_care9C[0x134 - 0xDC]; // 0xDC
                                  // 0x134
};

struct Actor2DManager;

struct Actor2DGroup;

struct Actor2D {
  char __unk4[8];                                         // 0x4
  float pos[3];                                           // 0xC
  int32_t id;                                             // 0x18
  float left;                                             // 0x1C
  float top;                                              // 0x20
  float right;                                            // 0x24
  float bottom;                                           // 0x28
  float vx;                                               // 0x2C
  float vy;                                               // 0x30
  char __unk34[4];                                        // 0x34
  float direction;                                        // 0x38
  std::shared_ptr<AnimationController2D> anim_controller; // 0x3C
  char __unk44[4];                                        // 0x44
  float ox;                                               // 0x48
  float oy;                                               // 0x4C
  float skew[3];                                          // 0x50
  float rotation[3];                                      // 0x5C
  Actor2DManager *actor2d_mgr;                            // 0x68
  Actor2DGroup *actor2d_group;                            // 0x6C
  uint8_t active_flags;                                   // 0x70
  char probably_padding[3];                               // 0x71
  SQObject sq_obj;                                        // 0x74
  uint32_t collision_group;                               // 0x7C
  uint32_t collision_mask;                                // 0x80
  uint32_t callback_group;                                // 0x84
  uint32_t callback_mask;                                 // 0x88
  float hitLeft;                                          // 0x8C
  float hitTop;                                           // 0x90
  float hitRight;                                         // 0x94
  float hitBottom;                                        // 0x98
  char __unk9C[0xC];                                      // 0x9C
  SqratFunction update_func;                              // 0xA8
  SqratFunction __sqrat_funcBC;                           // 0xBC
  char __unkD0[8];                                        // 0xD0
  void *__ptrD8;                                          // 0xD8
  uint32_t group_flags;                                   // 0xDC
  uint32_t list_idx;                                      // 0xE0
  uint32_t __uintE4;                                      // 0xE4
  uint32_t __id2;                                         // 0xE8
                                                          // 0xEC
};

static_assert(sizeof(Actor2D) == 0xEC);

struct Actor2DGroup {
  void *vtbl;                                     // 0x0
  std::shared_ptr<Actor2DGroup> shared_ptr;       // 0x4
  std::list<std::shared_ptr<Actor2D>> actor_list; // 0xC
  std::vector<Actor2D *> actor_vec;               // 0x14
  uint32_t size;                                  // 0x20
  uint32_t update_mask;                           // 0x24
  bool pending_release;                           // 0x28
  char probably_padding[3];                       // 0x29
  char __unk2C[0xC];                              // 0x2C
  std::shared_ptr<World2D> world;                 // 0x38
  SqratFunction on_hit_collision;                 // 0x40
  SqratFunction on_hit_actor;                     // 0x54
  SqratFunction on_move;                          // 0x68
  char __unk7C[4];                                // 0x7C
  SqratObject camera_obj;                         // 0x80
  Camera2D *camera;                               // 0x94
  void(thiscall *update_func)(Actor2DGroup *);    // 0x98
                                                  // 0x9C
};

static_assert(sizeof(Actor2DGroup) == 0x9C);

} // namespace Manbow

#endif